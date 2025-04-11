import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/screens/attendance/models_services.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:math';

class RecordedMeetingsList extends StatefulWidget {
  const RecordedMeetingsList({Key? key, required this.meetings}) : super(key: key);

  final List<ServicesForList> meetings;

  @override
  State<RecordedMeetingsList> createState() => _RecordedMeetingsListState();
}

class _RecordedMeetingsListState extends State<RecordedMeetingsList>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isLoading = true;
  String? _selectedMeetingId;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Simulate loading for better UX
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();
    final screenSize = MediaQuery.of(context).size;
    final isTabletOrLarger = screenSize.width >= 600;
    final isLargeScreen = screenSize.width >= 900;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // For large screens, put header and button in the same row
            if (isLargeScreen)
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildHeaderContent(isTabletOrLarger, isLargeScreen, isDarkMode),
                    _buildAddMeetingButtonContent(context, isDarkMode),
                  ],
                ),
              )
            // For smaller screens, stack them vertically
            else ...[
              _buildHeader(isTabletOrLarger, isLargeScreen, isDarkMode),
              _buildAddMeetingButton(context, isTabletOrLarger, isDarkMode),
            ],
            const SizedBox(height: 16),
            Expanded(
              child: _isLoading
                  ? _buildLoadingState(isTabletOrLarger)
                  : widget.meetings.isEmpty
                      ? _buildEmptyState(isDarkMode)
                      : _buildMeetingsList(
                          context, churchState, isTabletOrLarger, isLargeScreen, isDarkMode),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to extract header content for reuse
  Widget _buildHeaderContent(bool isTabletOrLarger, bool isLargeScreen, bool isDarkMode) {
    final headerTextColor = isDarkMode ? Colors.white : Colors.black87;
    final subtitleColor = isDarkMode ? Colors.white70 : Colors.black54;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: PoimenTheme.brand.withOpacity(isDarkMode ? 0.2 : 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                FontAwesomeIcons.calendarWeek,
                color: PoimenTheme.brand,
                size: isTabletOrLarger ? 24 : 20,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Recorded Meetings',
              style: TextStyle(
                fontSize: isTabletOrLarger ? 28 : 24,
                fontWeight: FontWeight.bold,
                color: headerTextColor,
                letterSpacing: -0.5,
              ),
            ),
            if (widget.meetings.isNotEmpty && !_isLoading) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: PoimenTheme.brand.withOpacity(isDarkMode ? 0.2 : 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${widget.meetings.length}',
                  style: TextStyle(
                    fontSize: isTabletOrLarger ? 16 : 14,
                    fontWeight: FontWeight.bold,
                    color: PoimenTheme.brand,
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'View and manage your meeting records',
          style: TextStyle(
            fontSize: isTabletOrLarger ? 16 : 14,
            color: subtitleColor,
          ),
        ),
      ],
    );
  }

  // Extract button content for reuse
  Widget _buildAddMeetingButtonContent(BuildContext context, bool isDarkMode) {
    return SizedBox(
      height: 60.0,
      child: ElevatedButton(
        onPressed: () {
          HapticFeedback.mediumImpact();
          Navigator.pushNamed(
            context,
            '/governorship/attendance-ticker',
          );
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) {
                return PoimenTheme.bad.withOpacity(0.8); // Darker when pressed
              } else if (states.contains(WidgetState.hovered)) {
                return PoimenTheme.bad.withOpacity(0.9); // Slightly darker on hover
              } else if (states.contains(WidgetState.disabled)) {
                return Colors.grey.shade400; // Grey when disabled
              }
              return PoimenTheme.bad; // Default red
            },
          ),
          foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          elevation: WidgetStateProperty.resolveWith<double>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) {
                return 2.0; // Lower elevation when pressed
              } else if (states.contains(WidgetState.hovered)) {
                return 8.0; // Higher elevation on hover
              }
              return 5.0; // Default elevation
            },
          ),
          overlayColor: WidgetStateProperty.all<Color>(Colors.white.withOpacity(0.1)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                FontAwesomeIcons.plusCircle,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Record New Meeting',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(bool isTabletOrLarger, bool isLargeScreen, bool isDarkMode) {
    final animation = Tween<Offset>(
      begin: const Offset(0, -0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutQuart,
    ));

    return SlideTransition(
      position: animation,
      child: Padding(
        padding: EdgeInsets.all(isTabletOrLarger ? 24.0 : 16.0),
        child: _buildHeaderContent(isTabletOrLarger, isLargeScreen, isDarkMode),
      ),
    );
  }

  Widget _buildAddMeetingButton(BuildContext context, bool isTabletOrLarger, bool isDarkMode) {
    final animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 0.8, curve: Curves.easeOutQuart),
    ));

    // For mobile: full width button
    // For tablet/larger: smaller button with right alignment
    final buttonWidth = isTabletOrLarger
        ? MediaQuery.of(context).size.width * 0.35
        : MediaQuery.of(context).size.width;

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.5),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: _animationController,
          curve: const Interval(0.2, 0.8, curve: Curves.easeOutQuart),
        )),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isTabletOrLarger ? 24.0 : 16.0,
          ),
          child: Align(
            alignment: isTabletOrLarger ? Alignment.centerRight : Alignment.center,
            child: SizedBox(
              width: buttonWidth,
              child: _buildAddMeetingButtonContent(context, isDarkMode),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState(bool isTabletOrLarger) {
    return isTabletOrLarger ? _buildLoadingGrid() : _buildLoadingList();
  }

  Widget _buildLoadingGrid() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300;
    final highlightColor = isDarkMode ? Colors.grey.shade600 : Colors.grey.shade100;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5, // Match the actual card aspect ratio
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: 6,
          itemBuilder: (_, __) => Container(
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey.shade800 : Colors.white,
              borderRadius: BorderRadius.circular(16),
              // Add some structure to the loading cards to better match actual cards
              border: Border.all(
                color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade200,
                width: 1.0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header placeholder
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 120,
                        height: 16,
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.grey.shade700 : Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.grey.shade700 : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Date placeholder
                  Container(
                    width: 80,
                    height: 12,
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.grey.shade700 : Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const Spacer(),
                  // Attendance count placeholder
                  Container(
                    width: 80,
                    height: 32,
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.grey.shade700 : Colors.white,
                      borderRadius: BorderRadius.circular(10),
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

  Widget _buildLoadingList() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300;
    final highlightColor = isDarkMode ? Colors.grey.shade600 : Colors.grey.shade100;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (_, __) => Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Container(
              height: 80, // Reduced from 100 to match actual card size better
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey.shade800 : Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(bool isDarkMode) {
    final animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.4, 1.0, curve: Curves.easeOutQuart),
    ));

    final iconColor = isDarkMode ? Colors.grey.shade600 : Colors.grey.shade400;
    final textColor = isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700;
    final subtitleColor = isDarkMode ? Colors.grey.shade500 : Colors.grey.shade600;

    return FadeTransition(
      opacity: animation,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.calendarXmark,
              size: 60,
              color: iconColor,
            ),
            const SizedBox(height: 24),
            Text(
              'No meetings recorded yet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                'Tap the "Record New Meeting" button above to add your first meeting record',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: subtitleColor,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 32),
            TextButton.icon(
              onPressed: () {
                HapticFeedback.selectionClick();
                Navigator.pushNamed(
                  context,
                  '/governorship/attendance-ticker',
                );
              },
              icon: Icon(
                FontAwesomeIcons.arrowRight,
                size: 16,
                color: PoimenTheme.brand,
              ),
              label: Text(
                'Get Started',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: PoimenTheme.brand,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMeetingsList(BuildContext context, SharedState churchState, bool isTabletOrLarger,
      bool isLargeScreen, bool isDarkMode) {
    final crossAxisCount = isLargeScreen ? 3 : (isTabletOrLarger ? 2 : 1);

    return isTabletOrLarger
        ? _buildAnimatedGridView(context, churchState, crossAxisCount, isDarkMode)
        : _buildAnimatedListView(context, churchState, isDarkMode);
  }

  Widget _buildAnimatedGridView(
      BuildContext context, SharedState churchState, int crossAxisCount, bool isDarkMode) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Adjust childAspectRatio to prevent cards from becoming too large on bigger screens
    double childAspectRatio = 1.5;
    if (screenWidth > 1200) {
      // Maintain a more consistent card size on very large screens
      childAspectRatio = 1.8;
    } else if (screenWidth > 900) {
      childAspectRatio = 1.6;
    }

    // Calculate maximum card width to prevent excessive growth
    const maxCardWidth = 320.0; // Maximum allowed width for a card
    final availableWidth = screenWidth - 48.0; // Total width minus padding
    final idealCardWidth = (availableWidth / crossAxisCount) - 16.0; // Subtract gap between cards
    final actualCardWidth = idealCardWidth > maxCardWidth ? maxCardWidth : idealCardWidth;

    // Recalculate crossAxisCount if cards would be too large
    final effectiveCrossAxisCount = idealCardWidth > maxCardWidth
        ? max(crossAxisCount, (availableWidth / (maxCardWidth + 16.0)).floor())
        : crossAxisCount;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: AnimationLimiter(
        child: GridView.builder(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: effectiveCrossAxisCount,
            childAspectRatio: childAspectRatio,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: widget.meetings.length,
          itemBuilder: (context, index) {
            final meeting = widget.meetings[index];
            return AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: 500),
              columnCount: effectiveCrossAxisCount,
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: _buildMeetingCard(context, churchState, meeting, isDarkMode),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAnimatedListView(BuildContext context, SharedState churchState, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: AnimationLimiter(
        child: RefreshIndicator(
          onRefresh: () async {
            HapticFeedback.mediumImpact();
            // In a real app, you'd refresh your data here
            await Future.delayed(const Duration(milliseconds: 1000));
          },
          color: PoimenTheme.brand,
          child: ListView.builder(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            itemCount: widget.meetings.length,
            itemBuilder: (context, index) {
              final meeting = widget.meetings[index];
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 500),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: _buildMeetingListItem(context, churchState, meeting, isDarkMode),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMeetingCard(
      BuildContext context, SharedState churchState, ServicesForList meeting, bool isDarkMode) {
    final isSelected = _selectedMeetingId == meeting.id;
    final cardBgColor = isDarkMode
        ? (isSelected ? Colors.grey.shade800 : Colors.grey.shade900)
        : (isSelected ? Colors.grey.shade50 : Colors.white);
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final secondaryTextColor = isDarkMode ? Colors.grey.shade400 : PoimenTheme.textSecondary;
    final tagBgColor = isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100;

    return Card(
      elevation: isSelected ? 5 : 3,
      color: cardBgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: meeting.markedAttendance
            ? BorderSide(
                color: isSelected ? Colors.green.shade700 : Colors.green,
                width: isSelected ? 2.0 : 1.5)
            : isSelected
                ? BorderSide(
                    color: isDarkMode ? Colors.grey.shade600 : Colors.grey.shade400, width: 2.0)
                : BorderSide.none,
      ),
      child: InkWell(
        onTap: () => _handleMeetingTap(context, churchState, meeting),
        onLongPress: () {
          HapticFeedback.mediumImpact();
          setState(() {
            _selectedMeetingId = isSelected ? null : meeting.id;
          });
        },
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        meeting.serviceDate.humanReadable,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: textColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: meeting.markedAttendance
                            ? Colors.green.withOpacity(isSelected ? 0.2 : 0.1)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: meeting.markedAttendance
                          ? const Icon(
                              FontAwesomeIcons.solidCircleCheck,
                              color: Colors.green,
                              size: 20,
                            )
                          : Icon(
                              FontAwesomeIcons.circle,
                              color: secondaryTextColor,
                              size: 20,
                            ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  timeago.format(meeting.serviceDate.date),
                  style: TextStyle(
                    color: secondaryTextColor,
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: tagBgColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        FontAwesomeIcons.userGroup,
                        color: secondaryTextColor,
                        size: 14,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${meeting.attendance ?? 0}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMeetingListItem(
      BuildContext context, SharedState churchState, ServicesForList meeting, bool isDarkMode) {
    final isSelected = _selectedMeetingId == meeting.id;
    final cardBgColor = isDarkMode
        ? (isSelected ? Colors.grey.shade800 : Colors.grey.shade900)
        : (isSelected ? Colors.grey.shade50 : Colors.white);
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final secondaryTextColor = isDarkMode ? Colors.grey.shade400 : PoimenTheme.textSecondary;
    final tagBgColor = isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100;
    final iconBgColor = isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100;

    return Card(
      elevation: isSelected ? 4 : 2,
      color: cardBgColor,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: meeting.markedAttendance
            ? BorderSide(
                color: isSelected ? Colors.green.shade700 : Colors.green,
                width: isSelected ? 2.0 : 1.0)
            : isSelected
                ? BorderSide(
                    color: isDarkMode ? Colors.grey.shade600 : Colors.grey.shade400, width: 2.0)
                : BorderSide.none,
      ),
      child: InkWell(
        onTap: () => _handleMeetingTap(context, churchState, meeting),
        onLongPress: () {
          HapticFeedback.mediumImpact();
          setState(() {
            _selectedMeetingId = isSelected ? null : meeting.id;
          });
        },
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: meeting.markedAttendance
                        ? Colors.green.withOpacity(isSelected ? 0.2 : 0.1)
                        : iconBgColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: meeting.markedAttendance
                        ? const Icon(
                            FontAwesomeIcons.solidCircleCheck,
                            color: Colors.green,
                            size: 22,
                          )
                        : Icon(
                            FontAwesomeIcons.circle,
                            color: secondaryTextColor,
                            size: 22,
                          ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meeting.serviceDate.humanReadable,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: textColor,
                        ),
                      ),
                      Text(
                        timeago.format(meeting.serviceDate.date),
                        style: TextStyle(
                          color: secondaryTextColor,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: tagBgColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.userGroup,
                                  color: secondaryTextColor,
                                  size: 12,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${meeting.attendance ?? 0}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: tagBgColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              meeting.typename,
                              style: TextStyle(
                                fontSize: 12,
                                color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(
                  FontAwesomeIcons.angleRight,
                  color: secondaryTextColor,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleMeetingTap(BuildContext context, SharedState churchState, ServicesForList meeting) {
    HapticFeedback.selectionClick();

    String serviceType = meeting.typename;
    churchState.serviceRecordId = meeting.id;

    // Visual feedback for tap
    setState(() {
      _selectedMeetingId = meeting.id;
    });

    // Small delay for better UX
    Future.delayed(const Duration(milliseconds: 150), () {
      if (!meeting.markedAttendance) {
        Navigator.pushNamed(
          context,
          '/${serviceType.toLowerCase()}/attendance-ticker',
        );
      } else {
        Navigator.pushNamed(
          context,
          '/meetings/attendance-report',
        );
      }
    });
  }
}
