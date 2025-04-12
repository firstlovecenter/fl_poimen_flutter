import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:poimen/screens/attendance/ticker/enums_ticker.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/services/cloudinary_service.dart' as cloudinary_custom;
import 'package:poimen/state/enums.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/avatar_with_initials.dart';
import 'package:poimen/widgets/submit_button_text.dart';
import 'package:provider/provider.dart';

class WidgetAttendanceTickerOnDate extends StatefulWidget {
  const WidgetAttendanceTickerOnDate(
      {Key? key, required this.church, required this.tickerMutation, required this.category})
      : super(key: key);

  final ServiceCategory category;
  final ChurchForMemberListByCategory church;
  final MutationHookResult tickerMutation;

  @override
  State<WidgetAttendanceTickerOnDate> createState() => _WidgetAttendanceTickerOnDateState();
}

class _WidgetAttendanceTickerOnDateState extends State<WidgetAttendanceTickerOnDate>
    with SingleTickerProviderStateMixin {
  final List<String> _presentMembers = [];
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  DateTime? _selectedDate;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: PoimenTheme.brand,
              onPrimary: Colors.white,
              surface: isDarkMode ? const Color(0xFF2A2A2A) : Colors.white,
              onSurface: isDarkMode ? Colors.white : Colors.black,
            ),
            dialogTheme: DialogThemeData(
                backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchQuery = '';
        _searchController.clear();
      } else {
        FocusScope.of(context).requestFocus(FocusNode());
      }
    });
  }

  int get _totalMembers {
    return widget.church.sheep.length + widget.church.goats.length + widget.church.deer.length;
  }

  double get _attendancePercentage {
    if (_totalMembers == 0) return 0;
    return _presentMembers.length / _totalMembers;
  }

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();

    // Sort all member lists alphabetically by first name
    final sortedSheep = List<MemberForList>.from(widget.church.sheep)
      ..sort((a, b) => a.firstName.toLowerCase().compareTo(b.firstName.toLowerCase()));
    final sortedGoats = List<MemberForList>.from(widget.church.goats)
      ..sort((a, b) => a.firstName.toLowerCase().compareTo(b.firstName.toLowerCase()));
    final sortedDeer = List<MemberForList>.from(widget.church.deer)
      ..sort((a, b) => a.firstName.toLowerCase().compareTo(b.firstName.toLowerCase()));

    final List<String> membership = [
      ...sortedSheep.map((sheep) => sheep.id),
      ...sortedGoats.map((goat) => goat.id),
      ...sortedDeer.map((deer) => deer.id),
    ];
    String recordId = '';

    if (widget.category == ServiceCategory.bussing) {
      recordId = churchState.bussingRecordId;
    } else if (widget.category == ServiceCategory.service) {
      recordId = churchState.serviceRecordId;
    }

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final screenSize = MediaQuery.of(context).size;
    final isTabletOrLarger = screenSize.width > 600;
    final isDesktop = screenSize.width > 900;

    // Apply container widths based on screen size for a more contained, elegant layout on larger screens
    final double contentMaxWidth = isDesktop
        ? 1200
        : isTabletOrLarger
            ? screenSize.width * 0.95
            : screenSize.width;

    return Scaffold(
      body: SafeArea(
        child: Center(
          // Center the content on larger screens
          child: Container(
            constraints: BoxConstraints(
              maxWidth: contentMaxWidth,
            ),
            child: Column(
              children: [
                _buildHeader(isDarkMode, isTabletOrLarger, isDesktop),
                Expanded(
                  child: _buildMemberList(isTabletOrLarger, isDesktop),
                ),
                _buildSubmitButton(membership, recordId, isDesktop),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDarkMode, bool isTabletOrLarger, bool isDesktop) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 24 : 16, vertical: isTabletOrLarger ? 16 : 12),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF2A2A2A) : Colors.white,
        borderRadius: isDesktop
            ? const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _isSearching
                    ? TextField(
                        controller: _searchController,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: 'Search members...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value.toLowerCase();
                          });
                        },
                      )
                    : Text(
                        'Attendance Tracking',
                        style: TextStyle(
                          fontSize: isDesktop
                              ? 26
                              : isTabletOrLarger
                                  ? 24
                                  : 20,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black87,
                        ),
                      ),
              ),
              IconButton(
                icon: Icon(_isSearching ? Icons.close : Icons.search),
                onPressed: _toggleSearch,
                color: PoimenTheme.brand,
                iconSize: isTabletOrLarger ? 28 : 24,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: isDesktop ? MainAxisAlignment.end : MainAxisAlignment.center,
            children: [
              if (isDesktop)
                SizedBox(
                  width: 350,
                  child: GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _selectedDate == null
                                ? 'Select date'
                                : DateFormat('EEEE, MMMM d, y').format(_selectedDate!),
                            style: TextStyle(
                              fontSize: isDesktop
                                  ? 18
                                  : isTabletOrLarger
                                      ? 16
                                      : 14,
                              color: _selectedDate == null
                                  ? isDarkMode
                                      ? Colors.grey
                                      : Colors.grey.shade700
                                  : isDarkMode
                                      ? Colors.white
                                      : Colors.black87,
                            ),
                          ),
                          Icon(
                            Icons.calendar_today,
                            color: PoimenTheme.brand,
                            size: isTabletOrLarger ? 24 : 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              else
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _selectedDate == null
                                ? 'Select date'
                                : DateFormat('EEEE, MMMM d, y').format(_selectedDate!),
                            style: TextStyle(
                              fontSize: isDesktop
                                  ? 18
                                  : isTabletOrLarger
                                      ? 16
                                      : 14,
                              color: _selectedDate == null
                                  ? isDarkMode
                                      ? Colors.grey
                                      : Colors.grey.shade700
                                  : isDarkMode
                                      ? Colors.white
                                      : Colors.black87,
                            ),
                          ),
                          Icon(
                            Icons.calendar_today,
                            color: PoimenTheme.brand,
                            size: isTabletOrLarger ? 24 : 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          if (_selectedDate != null) ...[
            const SizedBox(height: 16),
            _buildAttendanceStats(isDarkMode, isTabletOrLarger, isDesktop),
          ],
        ],
      ),
    );
  }

  Widget _buildAttendanceStats(bool isDarkMode, bool isTabletOrLarger, bool isDesktop) {
    final attendanceColor = _attendancePercentage > 0.7
        ? Colors.green
        : _attendancePercentage > 0.4
            ? Colors.orange
            : Colors.red;

    return AnimatedOpacity(
      opacity: _selectedDate != null ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: isTabletOrLarger ? 12 : 8, horizontal: isTabletOrLarger ? 20 : 16),
        decoration: BoxDecoration(
          color: isDarkMode
              ? PoimenTheme.darkCardColor.withOpacity(0.6)
              : PoimenTheme.lightCardColor.withOpacity(0.6),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: isDesktop
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStat(
                      'Total Members', _totalMembers.toString(), isDarkMode, isTabletOrLarger),
                  _buildStatDivider(isDarkMode),
                  _buildStat('Present', '${_presentMembers.length}', isDarkMode, isTabletOrLarger),
                  _buildStatDivider(isDarkMode),
                  _buildStat('Absent', '${_totalMembers - _presentMembers.length}', isDarkMode,
                      isTabletOrLarger),
                  _buildStatDivider(isDarkMode),
                  Column(
                    children: [
                      Text(
                        'Attendance',
                        style: TextStyle(
                          fontSize: isTabletOrLarger ? 14 : 12,
                          color: isDarkMode ? Colors.grey : Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: isTabletOrLarger ? 48 : 40,
                        width: isTabletOrLarger ? 48 : 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: attendanceColor,
                          boxShadow: [
                            BoxShadow(
                              color: attendanceColor.withOpacity(0.3),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            '${(_attendancePercentage * 100).toInt()}%',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: isTabletOrLarger ? 16 : 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Members',
                        style: TextStyle(
                          fontSize: isTabletOrLarger ? 14 : 12,
                          color: isDarkMode ? Colors.grey : Colors.grey.shade700,
                        ),
                      ),
                      Text(
                        _totalMembers.toString(),
                        style: TextStyle(
                          fontSize: isTabletOrLarger ? 18 : 16,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Present',
                        style: TextStyle(
                          fontSize: isTabletOrLarger ? 14 : 12,
                          color: isDarkMode ? Colors.grey : Colors.grey.shade700,
                        ),
                      ),
                      Text(
                        '${_presentMembers.length}',
                        style: TextStyle(
                          fontSize: isTabletOrLarger ? 18 : 16,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: attendanceColor,
                      boxShadow: [
                        BoxShadow(
                          color: attendanceColor.withOpacity(0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '${(_attendancePercentage * 100).toInt()}%',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: isTabletOrLarger ? 14 : 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildStat(String label, String value, bool isDarkMode, bool isTabletOrLarger) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTabletOrLarger ? 14 : 12,
            color: isDarkMode ? Colors.grey : Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: isTabletOrLarger ? 18 : 16,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildStatDivider(bool isDarkMode) {
    return Container(
      height: 30,
      width: 1,
      color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
    );
  }

  Widget _buildMemberList(bool isTabletOrLarger, bool isDesktop) {
    if (_selectedDate == null) {
      return FadeTransition(
        opacity: _fadeAnimation,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.calendar_today,
                size: isDesktop
                    ? 100
                    : isTabletOrLarger
                        ? 80
                        : 60,
                color: Colors.grey.withOpacity(0.5),
              ),
              const SizedBox(height: 24),
              Text(
                'Please select a date first',
                style: TextStyle(
                  fontSize: isDesktop
                      ? 22
                      : isTabletOrLarger
                          ? 20
                          : 18,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () => _selectDate(context),
                icon: const Icon(Icons.date_range),
                label: const Text('Select Date'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop
                        ? 32
                        : isTabletOrLarger
                            ? 24
                            : 16,
                    vertical: isDesktop
                        ? 20
                        : isTabletOrLarger
                            ? 16
                            : 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final memberWidgets = <Widget>[];

    // Custom widget builder function to avoid code duplication
    Widget buildMemberSection(List<MemberForList> members, MemberCategory category) {
      // Filter members based on search query if searching
      final filteredMembers = _searchQuery.isEmpty
          ? members
          : members
              .where((member) =>
                  '${member.firstName} ${member.lastName}'.toLowerCase().contains(_searchQuery))
              .toList();

      if (filteredMembers.isEmpty) {
        return const SizedBox.shrink();
      }

      Color categoryColor;
      switch (category) {
        case MemberCategory.Sheep:
          categoryColor = Colors.green.shade700;
          break;
        case MemberCategory.Goat:
          categoryColor = Colors.orange.shade700;
          break;
        case MemberCategory.Deer:
          categoryColor = Colors.blue.shade700;
          break;
        default:
          categoryColor = PoimenTheme.brand;
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isDarkMode ? categoryColor.withOpacity(0.2) : categoryColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: categoryColor.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  category == MemberCategory.Sheep
                      ? Icons.people_alt
                      : category == MemberCategory.Goat
                          ? Icons.person_add
                          : Icons.person_search,
                  color: categoryColor,
                  size: isTabletOrLarger ? 22 : 18,
                ),
                const SizedBox(width: 8),
                Text(
                  category.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: isTabletOrLarger ? 18 : 16,
                    color: categoryColor,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey.shade800 : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Text(
                    '${filteredMembers.length}',
                    style: TextStyle(
                      fontSize: isTabletOrLarger ? 14 : 12,
                      fontWeight: FontWeight.bold,
                      color: categoryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ...filteredMembers.map((member) {
            final isPresent = _presentMembers.contains(member.id);
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: isPresent
                    ? (isDarkMode ? Colors.green.shade900.withOpacity(0.3) : Colors.green.shade50)
                    : (isDarkMode ? Colors.grey.shade800 : Colors.white),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
                border: isPresent
                    ? Border.all(
                        color: isDarkMode ? Colors.green.shade700 : Colors.green.shade300,
                        width: 1,
                      )
                    : null,
              ),
              child: CheckboxListTile(
                activeColor: PoimenTheme.brand,
                checkColor: Colors.white,
                value: isPresent,
                onChanged: (bool? value) {
                  setState(() {
                    if (value!) {
                      _presentMembers.add(member.id);
                    } else {
                      _presentMembers.remove(member.id);
                    }
                  });
                },
                secondary: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: AvatarWithInitials(
                        member: member,
                        foregroundImage: cloudinary_custom.CloudinaryImage(
                          url: member.pictureUrl,
                          size: cloudinary_custom.ImageSize.xs,
                        ).image,
                      ),
                    ),
                    if (isPresent)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isDarkMode ? Colors.black : Colors.white,
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.check,
                            size: 10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
                title: Text(
                  '${member.firstName} ${member.lastName}',
                  style: TextStyle(
                    fontWeight: isPresent ? FontWeight.bold : FontWeight.normal,
                    fontSize: isTabletOrLarger ? 16 : 14,
                  ),
                ),
                subtitle: member.phoneNumber.isNotEmpty
                    ? Row(
                        children: [
                          Icon(
                            Icons.phone,
                            size: 14,
                            color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            member.phoneNumber,
                            style: TextStyle(
                              fontSize: 12,
                              color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                            ),
                          ),
                        ],
                      )
                    : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          }).toList(),
        ],
      );
    }

    // Add member sections
    if (widget.church.sheep.isNotEmpty) {
      memberWidgets.add(buildMemberSection(widget.church.sheep, MemberCategory.Sheep));
    }

    if (widget.church.goats.isNotEmpty) {
      memberWidgets.add(buildMemberSection(widget.church.goats, MemberCategory.Goat));
    }

    if (widget.church.deer.isNotEmpty) {
      memberWidgets.add(buildMemberSection(widget.church.deer, MemberCategory.Deer));
    }

    // Handle empty state or search with no results
    if (memberWidgets.isEmpty ||
        (_searchQuery.isNotEmpty &&
            !widget.church.sheep
                .any((m) => '${m.firstName} ${m.lastName}'.toLowerCase().contains(_searchQuery)) &&
            !widget.church.goats
                .any((m) => '${m.firstName} ${m.lastName}'.toLowerCase().contains(_searchQuery)) &&
            !widget.church.deer
                .any((m) => '${m.firstName} ${m.lastName}'.toLowerCase().contains(_searchQuery)))) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _searchQuery.isEmpty ? Icons.people_outline : Icons.search_off,
              size: isDesktop ? 80 : 60,
              color: Colors.grey.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              _searchQuery.isEmpty ? 'No members available' : 'No members match "$_searchQuery"',
              style: TextStyle(
                fontSize: isDesktop ? 18 : 16,
                color: Colors.grey,
              ),
            ),
            if (_searchQuery.isNotEmpty) ...[
              const SizedBox(height: 16),
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    _searchQuery = '';
                    _searchController.clear();
                  });
                },
                icon: const Icon(Icons.clear),
                label: const Text('Clear Search'),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: isTabletOrLarger ? 20 : 16,
                    vertical: isTabletOrLarger ? 12 : 8,
                  ),
                ),
              ),
            ],
          ],
        ),
      );
    }

    return isTabletOrLarger
        ? ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: LayoutBuilder(builder: (context, constraints) {
              const double itemHeight = 90; // Approximate height of each list item
              final double itemWidth = isDesktop
                  ? (constraints.maxWidth / 3) - 16 // 3 columns for desktop
                  : (constraints.maxWidth / 2) - 16; // 2 columns for tablet

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isDesktop ? 3 : 2,
                  childAspectRatio: itemWidth / itemHeight,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 0,
                ),
                padding: const EdgeInsets.only(top: 8, bottom: 90),
                itemCount: widget.church.sheep.length +
                    widget.church.goats.length +
                    widget.church.deer.length,
                itemBuilder: (context, index) {
                  MemberForList? member;
                  // Find the appropriate member based on index
                  if (index < widget.church.sheep.length) {
                    member = widget.church.sheep[index];
                  } else if (index < widget.church.sheep.length + widget.church.goats.length) {
                    member = widget.church.goats[index - widget.church.sheep.length];
                  } else {
                    member = widget.church
                        .deer[index - widget.church.sheep.length - widget.church.goats.length];
                  }

                  final isPresent = _presentMembers.contains(member.id);
                  return Container(
                    margin: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: isPresent
                          ? (isDarkMode
                              ? Colors.green.shade900.withOpacity(0.3)
                              : Colors.green.shade50)
                          : (isDarkMode ? Colors.grey.shade800 : Colors.white),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ],
                      border: isPresent
                          ? Border.all(
                              color: isDarkMode ? Colors.green.shade700 : Colors.green.shade300,
                              width: 1,
                            )
                          : null,
                    ),
                    child: CheckboxListTile(
                      activeColor: PoimenTheme.brand,
                      checkColor: Colors.white,
                      value: isPresent,
                      onChanged: (bool? value) {
                        setState(() {
                          if (value!) {
                            _presentMembers.add(member!.id);
                          } else {
                            _presentMembers.remove(member!.id);
                          }
                        });
                      },
                      secondary: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
                                width: 2,
                              ),
                            ),
                            child: AvatarWithInitials(
                              member: member,
                              foregroundImage: cloudinary_custom.CloudinaryImage(
                                url: member.pictureUrl,
                                size: cloudinary_custom.ImageSize.xs,
                              ).image,
                            ),
                          ),
                          if (isPresent)
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isDarkMode ? Colors.black : Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.check,
                                  size: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                        ],
                      ),
                      title: Text(
                        '${member.firstName} ${member.lastName}',
                        style: TextStyle(
                          fontWeight: isPresent ? FontWeight.bold : FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                      subtitle: member.phoneNumber.isNotEmpty
                          ? Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  size: 12,
                                  color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  member.phoneNumber,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                                  ),
                                ),
                              ],
                            )
                          : null,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
              );
            }),
          )
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 90),
              child: Column(
                children: memberWidgets,
              ),
            ),
          );
  }

  Widget _buildSubmitButton(List<String> membership, String recordId, bool isDesktop) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: isDesktop ? 400 : double.infinity,
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              onPressed: (_selectedDate == null || widget.tickerMutation.result.isLoading)
                  ? null
                  : () {
                      final absentMembers =
                          membership.where((member) => !_presentMembers.contains(member)).toList();

                      widget.tickerMutation.runMutation({
                        'governorshipId': context.read<SharedState>().governorshipId,
                        'hubId': context.read<SharedState>().hubId,
                        'date': _selectedDate.toString().split(' ')[0],
                        'presentMembers': _presentMembers,
                        'absentMembers': absentMembers,
                        'recordId': recordId,
                      });
                    },
              child: widget.tickerMutation.result.isLoading
                  ? const SubmittingButtonText()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.save),
                        const SizedBox(width: 8),
                        Text(
                          'Submit Attendance',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

validate(BuildContext context, List<String> fields) {
  if (fields.contains('')) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please upload a picture of the attendance'),
      ),
    );
    return false;
  }

  return true;
}
