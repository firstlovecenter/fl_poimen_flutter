import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart'; // Add import for SchedulerBinding and SchedulerPhase

class SearchableDropdown<T> extends StatefulWidget {
  final String label;
  final String hintText;
  final T? value;
  final List<T> items;
  final Function(T?) onChanged;
  final bool isLoading;
  final String? errorText;
  final Function(String) onSearch;
  final Widget? prefixIcon;
  final bool isRequired;
  final String noItemsFoundText;

  const SearchableDropdown({
    Key? key,
    required this.label,
    required this.hintText,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.onSearch,
    this.isLoading = false,
    this.errorText,
    this.prefixIcon,
    this.isRequired = false,
    this.noItemsFoundText = 'No items found',
  }) : super(key: key);

  @override
  State<SearchableDropdown<T>> createState() => _SearchableDropdownState<T>();
}

class _SearchableDropdownState<T> extends State<SearchableDropdown<T>> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  final FocusNode _focusNode = FocusNode();
  bool _isOpen = false;
  bool _itemSelected = false;
  String _lastSearchTerm = '';

  @override
  void initState() {
    super.initState();

    // Setup focus listener
    _focusNode.addListener(_onFocusChange);

    // Initialize with current value if present
    if (widget.value != null) {
      _searchController.text = widget.value.toString();
      _itemSelected = true;
    }
  }

  void _onFocusChange() {
    // If losing focus and nothing was selected, restore the previous value
    if (!_focusNode.hasFocus) {
      if (_isOpen) {
        _removeOverlay();
      }

      if (!_itemSelected && widget.value != null) {
        // Restore the previous selection if we have one
        setState(() {
          _searchController.text = widget.value.toString();
        });
      }
    } else if (_focusNode.hasFocus && _searchController.text.isEmpty) {
      // When focused and empty, show all items
      _itemSelected = false;

      // Schedule the overlay creation after the current build is complete
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onSearch('');
        _createOverlay();
      });
    }
  }

  @override
  void didUpdateWidget(SearchableDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Update text controller when the value changes from parent
    if (widget.value != oldWidget.value) {
      if (widget.value != null) {
        _searchController.text = widget.value.toString();
        _itemSelected = true;
      } else {
        _searchController.text = '';
        _itemSelected = false;
      }
    }

    // If items have changed from last time, update the dropdown if it's open
    if (widget.items != oldWidget.items && _isOpen) {
      // Schedule the overlay rebuild after the current build is complete
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_isOpen && mounted) {
          _removeOverlay();
          _createOverlay();
        }
      });
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _removeOverlay();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _createOverlay() {
    // Don't create an overlay if one already exists
    if (_overlayEntry != null || !mounted) return;

    // Don't try to create an overlay during build
    if (SchedulerBinding.instance.schedulerPhase == SchedulerPhase.persistentCallbacks) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _createOverlay();
      });
      return;
    }

    _isOpen = true;

    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 5),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: widget.items.isEmpty ? 50.0 : math.min(200.0, widget.items.length * 50.0),
              child: widget.isLoading
                  ? const Center(
                      child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator()))
                  : widget.items.isEmpty
                      ? Center(child: Text(widget.noItemsFoundText))
                      : ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: widget.items.length,
                          itemBuilder: (context, index) {
                            final item = widget.items[index];
                            return ListTile(
                              dense: true,
                              title: Text(item.toString()),
                              onTap: () {
                                setState(() {
                                  _searchController.text =
                                      item.toString(); // Update the searchController value
                                  _itemSelected = true;
                                });
                                widget.onChanged(item);
                                _removeOverlay();

                                // Clear focus after selection
                                FocusScope.of(context).unfocus();
                              },
                            );
                          },
                        ),
            ),
          ),
        ),
      ),
    );

    // Add the overlay entry to the Overlay
    final overlay = Overlay.of(context, rootOverlay: true);
    if (mounted) {
      overlay.insert(_overlayEntry!);
    }
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _isOpen = false;
  }

  void _toggleOverlay() {
    if (_isOpen) {
      _removeOverlay();
    } else {
      // Schedule overlay creation after the current build phase
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          // When toggling open, search with current text
          widget.onSearch(_searchController.text);
          _createOverlay();
        }
      });
    }
  }

  void _onSearchChanged(String query) {
    _lastSearchTerm = query;
    _itemSelected = false;

    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        widget.onSearch(query);

        // Schedule overlay manipulation after the current build phase
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            // Display the dropdown with search results
            if (_isOpen) {
              // If already open, refresh the dropdown to show new results
              _removeOverlay();
            }
            _createOverlay();
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get theme colors for dark mode compatibility
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    final fillColor = isDarkMode ? Colors.grey[850] : Colors.grey[50];
    final borderColor = isDarkMode ? Colors.grey[700] : Colors.grey[300];
    final focusedBorderColor = Theme.of(context).primaryColor;

    return CompositedTransformTarget(
      link: _layerLink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _searchController,
            focusNode: _focusNode,
            decoration: InputDecoration(
              labelText: widget.label + (widget.isRequired ? ' *' : ''),
              hintText: widget.hintText,
              prefixIcon: widget.prefixIcon != null
                  ? Icon(
                      (widget.prefixIcon as Icon).icon,
                      size: 16,
                      color: (widget.prefixIcon as Icon).color,
                    )
                  : null,
              prefixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 40),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.isLoading)
                    const SizedBox(
                        width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)),
                  IconButton(
                    icon: const Icon(Icons.arrow_drop_down, size: 20),
                    onPressed: _toggleOverlay,
                  ),
                ],
              ),
              suffixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 40),
              errorText: widget.errorText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: borderColor!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: focusedBorderColor, width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.red, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.red, width: 2),
              ),
              filled: true,
              fillColor: fillColor,
            ),
            onChanged: _onSearchChanged,
            onTap: () {
              // Don't try to manipulate the overlay during build
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!_isOpen && mounted) {
                  // When tapped, search with current text
                  widget.onSearch(_searchController.text);
                  _createOverlay();
                }
              });
            },
            validator: (value) {
              if (widget.isRequired && (value == null || value.isEmpty)) {
                return 'This field is required';
              }
              return null;
            },
          ),
          if (_itemSelected && widget.value != null)
            Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 4.0),
              child: Text(
                'Selected: ${widget.value.toString()}',
                style: TextStyle(
                  fontSize: 12,
                  color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
