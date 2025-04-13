import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/screens/duties/visitation/models_visitation.dart';
import 'package:poimen/screens/duties/visitation/widget_visitation_report_form.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/avatar_with_initials.dart';
import 'package:poimen/widgets/icon_contact.dart';
import 'package:poimen/widgets/no_data.dart';
import 'package:poimen/widgets/traliing_alert_number.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ChurchOutstandingVisitationList extends StatefulWidget {
  const ChurchOutstandingVisitationList({Key? key, required this.church}) : super(key: key);

  final ChurchForOutstandingVisitationList church;

  @override
  ChurchOutstandingVisitationListState createState() => ChurchOutstandingVisitationListState();
}

class ChurchOutstandingVisitationListState extends State<ChurchOutstandingVisitationList> {
  final TextEditingController _searchController = TextEditingController();
  List<OutstandingVisitationForList> _filteredMembers = [];
  bool _isLoading = true;

  // Selected member for tablet/desktop detail view
  OutstandingVisitationForList? _selectedMember;

  @override
  void initState() {
    super.initState();
    _filteredMembers = widget.church.outstandingVisitations;
    _searchController.addListener(_filterMembers);

    // Set the first member as selected for tablet/desktop view if available
    if (_filteredMembers.isNotEmpty) {
      _selectedMember = _filteredMembers[0];
    }

    // Simulate loading for better UX
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterMembers() {
    final String query = _searchController.text.toLowerCase();
    List<OutstandingVisitationForList> filteredList = [];
    for (OutstandingVisitationForList member in widget.church.outstandingVisitations) {
      final String memberName =
          '${member.firstName} ${member.lastName} ${member.visitationArea}'.toLowerCase();
      if (memberName.contains(query)) {
        filteredList.add(member);
      }
    }
    setState(() {
      _filteredMembers = filteredList;

      // Reset selected member if filtered list is empty
      if (_filteredMembers.isEmpty) {
        _selectedMember = null;
      }
      // Otherwise, if the currently selected member is not in the filtered list, select the first one
      else if (_selectedMember != null && !_filteredMembers.contains(_selectedMember)) {
        _selectedMember = _filteredMembers[0];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Responsive design variables
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;
    final isDesktop = size.width >= 900;

    // Theme detection
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    // Colors based on theme
    final cardColor = isDarkMode ? PoimenTheme.darkCardColor : Colors.white;
    final backgroundColor = isDarkMode ? Colors.black12 : Colors.grey.shade50;
    final borderColor = isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200;
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final subtitleColor = isDarkMode ? Colors.grey.shade300 : Colors.grey.shade700;
    final searchBarColor = isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200;

    // For mobile devices, use the original layout
    if (!isTablet) {
      return _buildMobileLayout(
        backgroundColor: backgroundColor,
        cardColor: cardColor,
        textColor: textColor,
        subtitleColor: subtitleColor,
        searchBarColor: searchBarColor,
        isDarkMode: isDarkMode,
      );
    }

    // For tablet and desktop, use a master-detail layout
    return _buildTabletDesktopLayout(
      backgroundColor: backgroundColor,
      cardColor: cardColor,
      borderColor: borderColor,
      textColor: textColor,
      subtitleColor: subtitleColor,
      searchBarColor: searchBarColor,
      isDarkMode: isDarkMode,
      isDesktop: isDesktop,
    );
  }

  Widget _buildMobileLayout({
    required Color backgroundColor,
    required Color cardColor,
    required Color textColor,
    required Color subtitleColor,
    required Color searchBarColor,
    required bool isDarkMode,
  }) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0),
                  child: Text(
                    'These people have not been visited during the current shepherding cycle',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                // Search bar
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Search by name or location',
                      hintText: 'Name or location',
                      prefixIcon: Icon(FontAwesomeIcons.magnifyingGlass,
                          size: 16, color: PoimenTheme.brand),
                      filled: true,
                      fillColor: searchBarColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    ),
                    style: TextStyle(color: textColor),
                  ),
                ),

                Expanded(
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : AnimationLimiter(
                          child: ListView(
                            children: [
                              // Stats cards
                              Wrap(
                                spacing: 12.0,
                                runSpacing: 12.0,
                                alignment: WrapAlignment.center,
                                children: [
                                  // Visits Remaining Card
                                  _buildStatsCard(
                                    context: context,
                                    icon: FontAwesomeIcons.doorOpen,
                                    iconColor: Colors.red,
                                    title: 'Visits Remaining',
                                    count: widget.church.outstandingVisitations.length,
                                    variant: TrailingCardAlertNumberVariant.red,
                                    backgroundColor: cardColor,
                                    textColor: textColor,
                                    isDarkMode: isDarkMode,
                                  ),

                                  // Visits Completed Card
                                  _buildStatsCard(
                                    context: context,
                                    icon: FontAwesomeIcons.solidThumbsUp,
                                    iconColor: Colors.green,
                                    title: 'Visits Completed',
                                    count: widget.church.completedVisitationsCount,
                                    variant: TrailingCardAlertNumberVariant.green,
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/${widget.church.typename.toLowerCase()}/completed-visitation',
                                      );
                                    },
                                    backgroundColor: cardColor,
                                    textColor: textColor,
                                    isDarkMode: isDarkMode,
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20),

                              // Show empty state or member list
                              if (_filteredMembers.isEmpty && _searchController.text.isNotEmpty)
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(24.0),
                                    child: Text(
                                      'No members found matching "${_searchController.text}"',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: textColor.withOpacity(0.7),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                              else
                                ...AnimationConfiguration.toStaggeredList(
                                  duration: const Duration(milliseconds: 375),
                                  childAnimationBuilder: (widget) => SlideAnimation(
                                    horizontalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: widget,
                                    ),
                                  ),
                                  children: noDataChecker(_filteredMembers.map((member) {
                                    return _buildVisitationMemberTile(
                                      context,
                                      member,
                                      cardColor: cardColor,
                                      textColor: textColor,
                                      subtitleColor: subtitleColor,
                                      isDarkMode: isDarkMode,
                                    );
                                  }).toList()),
                                ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabletDesktopLayout({
    required Color backgroundColor,
    required Color cardColor,
    required Color borderColor,
    required Color textColor,
    required Color subtitleColor,
    required Color searchBarColor,
    required bool isDarkMode,
    required bool isDesktop,
  }) {
    final size = MediaQuery.of(context).size;

    // Calculate master panel width based on screen size
    final masterWidth = isDesktop ? size.width * 0.35 : size.width * 0.4;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Row(
          children: [
            // Master view (member list)
            SizedBox(
              width: masterWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
                    child: Text(
                      'Outstanding Visitations',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Statistic: Visits Remaining
                        _buildCompactStatistic(
                          icon: FontAwesomeIcons.doorOpen,
                          iconColor: Colors.red,
                          label: 'Remaining',
                          value: widget.church.outstandingVisitations.length.toString(),
                          textColor: textColor,
                        ),

                        // Statistic: Visits Completed
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/${widget.church.typename.toLowerCase()}/completed-visitation',
                            );
                          },
                          borderRadius: BorderRadius.circular(8.0),
                          child: _buildCompactStatistic(
                            icon: FontAwesomeIcons.solidThumbsUp,
                            iconColor: Colors.green,
                            label: 'Completed',
                            value: widget.church.completedVisitationsCount.toString(),
                            textColor: textColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Search bar
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: 'Search members',
                        hintText: 'Name or location',
                        prefixIcon: Icon(FontAwesomeIcons.magnifyingGlass,
                            size: 16, color: PoimenTheme.brand),
                        filled: true,
                        fillColor: searchBarColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                      ),
                      style: TextStyle(color: textColor),
                    ),
                  ),

                  // Member list
                  Expanded(
                    child: _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : _filteredMembers.isEmpty
                            ? Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: Text(
                                    _searchController.text.isNotEmpty
                                        ? 'No members found matching "${_searchController.text}"'
                                        : 'No outstanding visitations',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: textColor.withOpacity(0.7),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemCount: _filteredMembers.length,
                                itemBuilder: (context, index) {
                                  final member = _filteredMembers[index];
                                  final isSelected = _selectedMember == member;

                                  return _buildMemberListItem(
                                    member: member,
                                    isSelected: isSelected,
                                    onTap: () {
                                      setState(() {
                                        _selectedMember = member;
                                      });
                                    },
                                    cardColor: cardColor,
                                    textColor: textColor,
                                    subtitleColor: subtitleColor,
                                    isDarkMode: isDarkMode,
                                  );
                                },
                              ),
                  ),
                ],
              ),
            ),

            // Divider
            VerticalDivider(
              width: 1,
              thickness: 1,
              color: borderColor,
            ),

            // Detail view
            Expanded(
              child: _selectedMember == null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.doorOpen,
                            size: 48,
                            color: textColor.withOpacity(0.4),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Select a member to view details',
                            style: TextStyle(
                              fontSize: 18,
                              color: textColor.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    )
                  : _buildDetailView(
                      member: _selectedMember!,
                      cardColor: cardColor,
                      textColor: textColor,
                      subtitleColor: subtitleColor,
                      backgroundColor: backgroundColor,
                      isDarkMode: isDarkMode,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberListItem({
    required OutstandingVisitationForList member,
    required bool isSelected,
    required VoidCallback onTap,
    required Color cardColor,
    required Color textColor,
    required Color subtitleColor,
    required bool isDarkMode,
  }) {
    CloudinaryImage picture = CloudinaryImage(url: member.pictureUrl, size: ImageSize.normal);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
      child: Card(
        color: isSelected
            ? (isDarkMode
                ? PoimenTheme.brand.withOpacity(0.2)
                : PoimenTheme.brand.withOpacity(0.05))
            : cardColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: BorderSide(
            color: isSelected
                ? PoimenTheme.brand
                : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.0),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                // Avatar
                AvatarWithInitials(
                  foregroundImage: picture.image,
                  member: member,
                  radius: 24,
                ),
                const SizedBox(width: 12),

                // Member details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${member.firstName} ${member.lastName}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (member.visitationArea.isNotEmpty)
                        Text(
                          member.visitationArea,
                          style: TextStyle(
                            fontSize: 13,
                            color: subtitleColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),

                // Selection indicator
                if (isSelected)
                  Container(
                    width: 4,
                    height: 48,
                    decoration: BoxDecoration(
                      color: PoimenTheme.brand,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailView({
    required OutstandingVisitationForList member,
    required Color cardColor,
    required Color textColor,
    required Color subtitleColor,
    required Color backgroundColor,
    required bool isDarkMode,
  }) {
    CloudinaryImage picture = CloudinaryImage(url: member.pictureUrl, size: ImageSize.lg);
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 900;
    var memberState = context.watch<SharedState>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with member info
          Center(
            child: Column(
              children: [
                // Photo
                Hero(
                  tag: 'member-${member.id}',
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: PoimenTheme.brand,
                        width: 3,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: AvatarWithInitials(
                        foregroundImage: picture.image,
                        member: member,
                        radius: 60,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Name
                InkWell(
                  onTap: () {
                    memberState.memberId = member.id;
                    memberState.member = member;
                    Navigator.pushNamed(context, '/member-details');
                  },
                  child: Text(
                    '${member.firstName} ${member.lastName}',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                // Status if available
                if (member.status != null) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: PoimenTheme.brand.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      member.status!,
                      style: TextStyle(
                        fontSize: 14,
                        color: PoimenTheme.brand,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Contact and location info
          Card(
            color: cardColor,
            elevation: isDarkMode ? 2 : 1,
            shadowColor: isDarkMode ? Colors.black : Colors.black12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contact Information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Contact details in a grid/row layout
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      // Phone
                      _buildContactItem(
                        icon: Icons.phone,
                        label: 'Phone',
                        value: member.phoneNumber,
                        color: PoimenTheme.phoneColor,
                        textColor: textColor,
                        subtitleColor: subtitleColor,
                        iconAction: () => launchUrl(Uri.parse('tel:${member.phoneNumber}')),
                      ),

                      // WhatsApp
                      _buildContactItem(
                        icon: FontAwesomeIcons.whatsapp,
                        label: 'WhatsApp',
                        value: member.whatsappNumber,
                        color: PoimenTheme.whatsappColor,
                        textColor: textColor,
                        subtitleColor: subtitleColor,
                        iconAction: () => launchUrl(Uri.parse(
                            'https://wa.me/${member.whatsappNumber}?text=Hello ${member.firstName}')),
                      ),

                      // Location
                      _buildContactItem(
                        icon: FontAwesomeIcons.locationDot,
                        label: 'Visitation Area',
                        value: member.visitationArea,
                        color: Colors.orange.withOpacity(0.2),
                        textColor: textColor,
                        subtitleColor: subtitleColor,
                        iconAction: member.location != null
                            ? () async {
                                final Uri launchUri = Uri.parse(
                                    'https://www.google.com/maps/search/?api=1&query=${member.location?.latitude}%2C${member.location?.longitude}');
                                await launchUrl(launchUri, mode: LaunchMode.externalApplication);
                              }
                            : null,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Map preview if location is available
          if (member.location != null)
            Card(
              color: cardColor,
              elevation: isDarkMode ? 2 : 1,
              shadowColor: isDarkMode ? Colors.black : Colors.black12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Location',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Static map image or placeholder
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          // This would be an actual map image in production
                          // For now, using a placeholder with coordinates
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  FontAwesomeIcons.locationDot,
                                  color: Colors.red,
                                  size: 32,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Latitude: ${member.location!.latitude.toStringAsFixed(6)}',
                                  style: TextStyle(color: textColor),
                                ),
                                Text(
                                  'Longitude: ${member.location!.longitude.toStringAsFixed(6)}',
                                  style: TextStyle(color: textColor),
                                ),
                              ],
                            ),
                          ),

                          // Clickable overlay to open map
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () async {
                                final Uri launchUri = Uri.parse(
                                    'https://www.google.com/maps/search/?api=1&query=${member.location?.latitude}%2C${member.location?.longitude}');
                                await launchUrl(launchUri, mode: LaunchMode.externalApplication);
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Container(),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Open in Maps button - made smaller and centered
                    Center(
                      child: SizedBox(
                        width: 200, // Reduced width from full width
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            final Uri launchUri = Uri.parse(
                                'https://www.google.com/maps/search/?api=1&query=${member.location?.latitude}%2C${member.location?.longitude}');
                            await launchUrl(launchUri, mode: LaunchMode.externalApplication);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: PoimenTheme.brand,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          icon: const Icon(FontAwesomeIcons.mapLocation, size: 16),
                          label: const Text('Open in Maps'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          const SizedBox(height: 24),

          // Record visitation button - made smaller and centered
          Center(
            child: SizedBox(
              width: 240, // Reduced width from full width
              child: ElevatedButton.icon(
                onPressed: () {
                  _showVisitationReportBottomSheet(context, member);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: PoimenTheme.brand,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                icon: const Icon(FontAwesomeIcons.clipboardCheck, size: 18),
                label: const Text(
                  'Record Visitation',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactStatistic({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    required Color textColor,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor, size: 18),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: textColor.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    required Color textColor,
    required Color subtitleColor,
    VoidCallback? iconAction,
  }) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              onPressed: iconAction,
              icon: Icon(icon, color: Colors.black87, size: 16),
              splashRadius: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: subtitleColor,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required int count,
    required TrailingCardAlertNumberVariant variant,
    required Color backgroundColor,
    required Color textColor,
    required bool isDarkMode,
    Color? iconColor,
    VoidCallback? onTap,
  }) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;

    // Adjust card width based on screen size
    final cardWidth = isTablet ? 280.0 : size.width * 0.44;

    return SizedBox(
      width: cardWidth,
      child: Card(
        color: backgroundColor,
        elevation: isDarkMode ? 2 : 1,
        shadowColor: isDarkMode ? Colors.black : Colors.black12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: BorderSide(
            color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
            width: 1,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(icon, color: iconColor, size: 20),
                        const SizedBox(width: 12),
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                    TrailingCardAlertNumber(
                      number: count,
                      variant: variant,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVisitationMemberTile(
    BuildContext context,
    OutstandingVisitationForList member, {
    required Color cardColor,
    required Color textColor,
    required Color subtitleColor,
    required bool isDarkMode,
  }) {
    CloudinaryImage picture = CloudinaryImage(url: member.pictureUrl, size: ImageSize.normal);
    var memberState = context.watch<SharedState>();
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Card(
        color: cardColor,
        elevation: isDarkMode ? 2 : 1,
        shadowColor: isDarkMode ? Colors.black : Colors.black12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: BorderSide(
            color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Member information row
              InkWell(
                onTap: () {
                  memberState.memberId = member.id;
                  memberState.member = member;
                  Navigator.pushNamed(context, '/member-details');
                },
                borderRadius: BorderRadius.circular(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      // Avatar
                      Hero(
                        tag: 'member-${member.id}',
                        child: AvatarWithInitials(
                          foregroundImage: picture.image,
                          member: member,
                          radius: 30,
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Member details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${member.firstName} ${member.lastName}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              member.visitationArea,
                              style: TextStyle(
                                fontSize: 14,
                                color: subtitleColor,
                              ),
                            ),
                            if (member.status != null) ...[
                              const SizedBox(height: 4),
                              Text(
                                member.status!,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: subtitleColor,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),

                      // Contact buttons
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ContactIcon(
                            icon: Icons.phone,
                            color: PoimenTheme.phoneColor,
                            phoneNumber: member.phoneNumber,
                          ),
                          const SizedBox(width: 8),
                          ContactIcon(
                            icon: FontAwesomeIcons.whatsapp,
                            color: PoimenTheme.whatsappColor,
                            whatsAppInfo: WhatsAppInfo(
                              number: member.whatsappNumber,
                              firstName: member.firstName,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Action buttons
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  if (member.location != null)
                    ElevatedButton.icon(
                      onPressed: () async {
                        final Uri launchUri = Uri.parse(
                            'https://www.google.com/maps/search/?api=1&query=${member.location?.latitude}%2C${member.location?.longitude}');

                        if (await canLaunchUrl(launchUri)) {
                          final bool nativeAppLaunchSucceeded = await launchUrl(
                            launchUri,
                            mode: LaunchMode.externalNonBrowserApplication,
                          );

                          if (!nativeAppLaunchSucceeded) {
                            await launchUrl(
                              launchUri,
                              mode: LaunchMode.externalApplication,
                            );
                          }
                        } else {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Could not launch map application'),
                              ),
                            );
                          }
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(PoimenTheme.whatsappColor),
                        foregroundColor: WidgetStateProperty.all(Colors.black),
                        padding: WidgetStateProperty.all(
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        ),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        elevation: WidgetStateProperty.all(0),
                      ),
                      icon: const Icon(
                        FontAwesomeIcons.locationPin,
                        size: 16,
                      ),
                      label: const Text('Go to Location'),
                    ),
                  ElevatedButton.icon(
                    onPressed: () {
                      _showVisitationReportBottomSheet(context, member);
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(PoimenTheme.brand),
                      foregroundColor: WidgetStateProperty.all(Colors.white),
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      elevation: WidgetStateProperty.all(0),
                    ),
                    icon: const Icon(
                      FontAwesomeIcons.pencil,
                      size: 16,
                    ),
                    label: const Text('Record Visit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showVisitationReportBottomSheet(BuildContext context, MemberForList member) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(25.0)),
          ),
          child: OutstandingVisitationReportForm(member: member),
        );
      },
    );
  }
}
