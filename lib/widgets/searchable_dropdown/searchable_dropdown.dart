import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && _isOpen) {
        _removeOverlay();
      }
    });

    // If there's an initial value, set the search text to its string representation
    if (widget.value != null) {
      _searchController.text = widget.value.toString();
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _removeOverlay();
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _createOverlay() {
    if (_overlayEntry != null) return;

    _isOpen = true;

    final RenderBox renderBox = context.findRenderObject() as RenderBox;
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
                  ? const Center(child: CircularProgressIndicator())
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
                                  _searchController.text = item.toString();
                                });
                                widget.onChanged(item);
                                _removeOverlay();
                              },
                            );
                          },
                        ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
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
      _createOverlay();
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      widget.onSearch(query);
      if (!_isOpen) {
        _createOverlay();
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
              if (!_isOpen) {
                _createOverlay();
              }
            },
          ),
        ],
      ),
    );
  }
}
