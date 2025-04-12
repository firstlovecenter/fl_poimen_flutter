import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/screens/membership/utils_paginated_member_list.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/state/enums.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/alert_box.dart';
import 'package:poimen/widgets/avatar_with_initials.dart';
import 'package:poimen/widgets/no_data.dart';
import 'package:provider/provider.dart';
import 'package:infinite_scroll/infinite_scroll.dart';

class ChurchMembershipList extends StatelessWidget {
  const ChurchMembershipList({Key? key, required this.church, this.fetchMore}) : super(key: key);

  final ChurchWithPaginatedMemberQueries church;
  final FetchMore? fetchMore;

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;
    final isDesktop = size.width >= 1200;

    // For larger screens, use a different layout structure
    if (isTablet) {
      return _buildTabletDesktopLayout(context, isDarkMode, isTablet, isDesktop);
    } else {
      return _buildMobileLayout(context, isDarkMode);
    }
  }

  Widget _buildMobileLayout(BuildContext context, bool isDarkMode) {
    const accordionHeight = 340.0;
    final totalCount = church.sheepCount + church.goatCount + church.deerCount;

    const headerStyle = TextStyle(
      color: Colors.white,
      fontSize: 15,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.3,
    );

    // Colors for category indicators
    const sheepColor = Colors.lightGreenAccent;
    const goatColor = Colors.amberAccent;
    const deerColor = Colors.redAccent;

    // Background colors for the summary cards
    final cardBgColor = isDarkMode ? PoimenTheme.darkCardColor : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black87;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        // Summary Card with total members
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: cardBgColor,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.users,
                      color: PoimenTheme.brand,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Total Members',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  totalCount.toString(),
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                    color: PoimenTheme.brand,
                  ),
                ),
                const SizedBox(height: 20),
                // Member category breakdown
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCategoryCount('Sheep', church.sheepCount, sheepColor, isDarkMode),
                    _buildCategoryCount('Goats', church.goatCount, goatColor, isDarkMode),
                    _buildCategoryCount('Deer', church.deerCount, deerColor, isDarkMode),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Enhanced Accordion
        Accordion(
          maxOpenSections: 1,
          scaleWhenAnimating: true,
          openAndCloseAnimation: true,
          paddingListHorizontal: 0,
          headerPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          headerBackgroundColor: isDarkMode ? const Color(0xFF222222) : PoimenTheme.brand,
          headerBackgroundColorOpened:
              isDarkMode ? const Color(0xFF2A2A2A) : PoimenTheme.brand.withOpacity(0.85),
          contentBackgroundColor:
              isDarkMode ? PoimenTheme.darkCardColor : PoimenTheme.lightCardColor,
          headerBorderRadius: 12,
          contentBorderRadius: 12,
          contentHorizontalPadding: 8,
          contentVerticalPadding: 8,
          contentBorderWidth: 1,
          contentBorderColor: isDarkMode ? PoimenTheme.darkCardColor : PoimenTheme.lightCardColor,
          sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
          sectionClosingHapticFeedback: SectionHapticFeedback.light,
          children: [
            AccordionSection(
              isOpen: true,
              contentBorderRadius: 12,
              leftIcon: const Row(
                children: [
                  Icon(FontAwesomeIcons.faceSmile, color: sheepColor, size: 18),
                  SizedBox(width: 8),
                ],
              ),
              header: Text('Sheep: ${church.sheepCount}', style: headerStyle),
              content: Container(
                height: accordionHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: MemberListQuery(
                  query: church.sheepQuery,
                  category: MemberCategory.Sheep,
                ),
              ),
            ),
            AccordionSection(
              contentBorderRadius: 12,
              leftIcon: const Row(
                children: [
                  Icon(FontAwesomeIcons.faceMeh, color: goatColor, size: 18),
                  SizedBox(width: 8),
                ],
              ),
              header: Text('Goats: ${church.goatCount}', style: headerStyle),
              content: Container(
                height: accordionHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: MemberListQuery(
                  query: church.goatQuery,
                  category: MemberCategory.Goat,
                ),
              ),
            ),
            AccordionSection(
              contentBorderRadius: 12,
              leftIcon: const Row(
                children: [
                  Icon(FontAwesomeIcons.faceFrown, color: deerColor, size: 18),
                  SizedBox(width: 8),
                ],
              ),
              header: Text('Deer: ${church.deerCount}', style: headerStyle),
              content: Container(
                height: accordionHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: MemberListQuery(
                  query: church.deerQuery,
                  category: MemberCategory.Deer,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTabletDesktopLayout(
      BuildContext context, bool isDarkMode, bool isTablet, bool isDesktop) {
    final totalCount = church.sheepCount + church.goatCount + church.deerCount;
    final screenSize = MediaQuery.of(context).size;

    // Colors for category indicators
    final sheepColor = Colors.green.shade400;
    final goatColor = Colors.amber.shade400;
    final deerColor = Colors.red.shade400;

    // Background colors for cards
    final cardBgColor = isDarkMode ? PoimenTheme.darkCardColor : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final headerBgColor = isDarkMode ? const Color(0xFF222222) : PoimenTheme.brand;

    // Calculate dimensions
    final sidebarWidth = isDesktop ? screenSize.width * 0.25 : screenSize.width * 0.32;
    final contentWidth = screenSize.width - sidebarWidth - 48; // accounting for padding
    final listHeight = screenSize.height - 120; // accounting for app bar and bottom padding

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left sidebar with summary stats
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: cardBgColor,
            child: SizedBox(
              width: sidebarWidth,
              height: listHeight,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.users,
                          color: PoimenTheme.brand,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Member Statistics',
                          style: TextStyle(
                            fontSize: isDesktop ? 22 : 20,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    // Total members count
                    _buildStatisticCard(
                      title: 'Total Members',
                      value: totalCount.toString(),
                      icon: FontAwesomeIcons.userGroup,
                      iconColor: PoimenTheme.brand,
                      isDarkMode: isDarkMode,
                      isLarge: true,
                    ),
                    const SizedBox(height: 24),
                    // Category breakdown
                    _buildStatisticCard(
                      title: 'Sheep',
                      value: church.sheepCount.toString(),
                      icon: FontAwesomeIcons.faceSmile,
                      iconColor: sheepColor,
                      isDarkMode: isDarkMode,
                      description: 'Active and engaged members',
                    ),
                    const SizedBox(height: 16),
                    _buildStatisticCard(
                      title: 'Goats',
                      value: church.goatCount.toString(),
                      icon: FontAwesomeIcons.faceMeh,
                      iconColor: goatColor,
                      isDarkMode: isDarkMode,
                      description: 'Occasionally attending members',
                    ),
                    const SizedBox(height: 16),
                    _buildStatisticCard(
                      title: 'Deer',
                      value: church.deerCount.toString(),
                      icon: FontAwesomeIcons.faceFrown,
                      iconColor: deerColor,
                      isDarkMode: isDarkMode,
                      description: 'Rarely seen members',
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Right side content with tabbed interface
          Expanded(
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              color: cardBgColor,
              child: SizedBox(
                height: listHeight,
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [
                      // Tab bar
                      Container(
                        decoration: BoxDecoration(
                          color: headerBgColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        child: TabBar(
                          indicatorColor: Colors.white,
                          indicatorWeight: 3,
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.white.withOpacity(0.7),
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          tabs: [
                            Tab(
                              icon: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(FontAwesomeIcons.faceSmile, color: sheepColor, size: 18),
                                  const SizedBox(width: 8),
                                  const Text('Sheep'),
                                ],
                              ),
                            ),
                            Tab(
                              icon: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(FontAwesomeIcons.faceMeh, color: goatColor, size: 18),
                                  const SizedBox(width: 8),
                                  const Text('Goats'),
                                ],
                              ),
                            ),
                            Tab(
                              icon: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(FontAwesomeIcons.faceFrown, color: deerColor, size: 18),
                                  const SizedBox(width: 8),
                                  const Text('Deer'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Tab content
                      Expanded(
                        child: TabBarView(
                          children: [
                            _buildTabContent(
                              category: MemberCategory.Sheep,
                              query: church.sheepQuery,
                              memberCount: church.sheepCount,
                              color: sheepColor,
                              title: 'Sheep',
                              description: 'Active and engaged members who attend regularly',
                              isDarkMode: isDarkMode,
                              isTablet: isTablet,
                            ),
                            _buildTabContent(
                              category: MemberCategory.Goat,
                              query: church.goatQuery,
                              memberCount: church.goatCount,
                              color: goatColor,
                              title: 'Goats',
                              description: 'Members who attend occasionally and need follow-up',
                              isDarkMode: isDarkMode,
                              isTablet: isTablet,
                            ),
                            _buildTabContent(
                              category: MemberCategory.Deer,
                              query: church.deerQuery,
                              memberCount: church.deerCount,
                              color: deerColor,
                              title: 'Deer',
                              description: 'Rarely seen members who need special attention',
                              isDarkMode: isDarkMode,
                              isTablet: isTablet,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent({
    required MemberCategory category,
    required dynamic query,
    required int memberCount,
    required Color color,
    required String title,
    required String description,
    required bool isDarkMode,
    required bool isTablet,
  }) {
    final bgColor = isDarkMode ? Colors.black12 : Colors.grey.shade50;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Info header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: bgColor,
            border: Border(
              bottom: BorderSide(
                color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
                width: 1.0,
              ),
            ),
          ),
          child: Row(
            children: [
              Icon(
                category == MemberCategory.Sheep
                    ? FontAwesomeIcons.faceSmile
                    : category == MemberCategory.Goat
                        ? FontAwesomeIcons.faceMeh
                        : FontAwesomeIcons.faceFrown,
                color: color,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$title ($memberCount)',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$memberCount members',
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Member list
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: MemberListQuery(
              query: query,
              category: category,
              gridView: !isTablet, // Use grid view for desktop, list for tablet
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatisticCard({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
    required bool isDarkMode,
    String? description,
    bool isLarge = false,
  }) {
    final bgColor = isDarkMode ? Colors.grey.shade900.withOpacity(0.5) : Colors.grey.shade50;
    final textColor = isDarkMode ? Colors.white : Colors.black87;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: isLarge ? 20 : 16,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: isLarge ? 22 : 18,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: isLarge ? 18 : 16,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: isLarge ? 36 : 26,
              fontWeight: FontWeight.bold,
              color: isLarge ? PoimenTheme.brand : textColor,
            ),
          ),
          if (description != null) ...[
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 13,
                color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCategoryCount(String label, int count, Color color, bool isDarkMode) {
    final bgColor = isDarkMode ? Colors.black26 : Colors.black.withOpacity(0.03);
    final textColor = isDarkMode ? Colors.white : Colors.black87;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget memberListTile(BuildContext context, MemberForList member) {
  final CloudinaryImage picture = CloudinaryImage(url: member.pictureUrl, size: ImageSize.normal);
  final memberState = context.watch<SharedState>();
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  final textColor = isDarkMode ? Colors.white : Colors.black87;
  final subtitleColor = isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700;

  return Card(
    margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    elevation: 0,
    color: isDarkMode ? Colors.grey.shade900.withOpacity(0.5) : Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: BorderSide(
        color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
        width: 0.5,
      ),
    ),
    child: InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        HapticFeedback.lightImpact();
        memberState.member = member;
        memberState.memberId = member.id;
        Navigator.pushNamed(context, '/member-details');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: ListTile(
          dense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          title: Text(
            '${member.firstName} ${member.lastName}',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          subtitle: Text(
            member.typename,
            style: TextStyle(
              fontSize: 13,
              color: subtitleColor,
            ),
          ),
          leading: Hero(
            tag: 'member-${member.id}',
            child: AvatarWithInitials(
              foregroundImage: picture.image,
              member: member,
            ),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade400,
            size: 20,
          ),
        ),
      ),
    ),
  );
}

Widget memberGridTile(BuildContext context, MemberForList member) {
  final CloudinaryImage picture = CloudinaryImage(url: member.pictureUrl, size: ImageSize.normal);
  final memberState = context.watch<SharedState>();
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  final textColor = isDarkMode ? Colors.white : Colors.black87;
  final subtitleColor = isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700;

  return Card(
    margin: const EdgeInsets.all(8),
    elevation: 0,
    color: isDarkMode ? Colors.grey.shade900.withOpacity(0.5) : Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(
        color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
        width: 0.5,
      ),
    ),
    child: InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        HapticFeedback.lightImpact();
        memberState.member = member;
        memberState.memberId = member.id;
        Navigator.pushNamed(context, '/member-details');
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'member-${member.id}',
              child: AvatarWithInitials(
                foregroundImage: picture.image,
                member: member,
                radius: 40,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '${member.firstName} ${member.lastName}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: textColor,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              member.typename,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: subtitleColor,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class MemberListQuery extends StatelessWidget {
  const MemberListQuery({
    Key? key,
    required this.query,
    required this.category,
    this.gridView = false,
  }) : super(key: key);

  final dynamic query;
  final MemberCategory category;
  final bool gridView;

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();
    ChurchString churchString = ChurchString(churchState.church.typename.toLowerCase());
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    const pageSize = 50; // Increased page size for grid view

    return Query(
        options: QueryOptions(
          document: query,
          variables: {'id': churchState.church.id, 'first': pageSize, 'after': 0},
        ),
        builder: (result, {fetchMore, refetch}) {
          if (result.hasException) {
            return Text(getGQLException(result.exception));
          }

          if ((result.data == null)) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(PoimenTheme.brand),
                      strokeWidth: 3,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Loading members...',
                    style: TextStyle(
                      color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            );
          }

          final church =
              ChurchForPaginatedMemberList.fromJson(result.data?[churchString.pluralLowerCase][0]);

          PaginatedMemberList? members;

          if (category == MemberCategory.Sheep) {
            members = church.sheepPaginated;
          }
          if (category == MemberCategory.Goat) {
            members = church.goatsPaginated;
          }
          if (category == MemberCategory.Deer) {
            members = church.deerPaginated;
          }

          return MemberInfiniteScrollList(
            fetchMore: fetchMore!,
            position: members?.position ?? 0,
            category: category,
            gridView: gridView,
            children: noDataChecker(
              members?.edges.map((edge) {
                    return gridView
                        ? memberGridTile(context, edge.node)
                        : memberListTile(context, edge.node);
                  }).toList() ??
                  [],
            ),
          );
        });
  }
}

class MemberInfiniteScrollList extends StatefulWidget {
  const MemberInfiniteScrollList({
    Key? key,
    required this.fetchMore,
    required this.children,
    required this.position,
    required this.category,
    this.gridView = false,
  }) : super(key: key);

  final FetchMore fetchMore;
  final MemberCategory category;
  final List<Widget> children;
  final int position;
  final bool gridView;

  @override
  State<MemberInfiniteScrollList> createState() => _MemberInfiniteScrollListState();
}

class _MemberInfiniteScrollListState extends State<MemberInfiniteScrollList> {
  bool _everyThingLoaded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var churchState = context.watch<SharedState>();
    ChurchString churchString = ChurchString(churchState.church.typename.toLowerCase());
    String churchLevel = churchString.pluralLowerCase;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    if (widget.gridView) {
      return InfiniteScrollGrid(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: 8, bottom: 16, left: 8, right: 8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.75,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        onLoadingStart: (page) async {
          await _loadMoreItems(churchLevel, isDarkMode);
        },
        loadingWidget: _buildLoadingIndicator(isDarkMode),
        everythingLoaded: _everyThingLoaded || widget.children.length < widget.position,
        children: widget.children,
      );
    } else {
      return InfiniteScrollList(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: 8, bottom: 16, left: 8, right: 8),
        shrinkWrap: true,
        onLoadingStart: (page) async {
          await _loadMoreItems(churchLevel, isDarkMode);
        },
        loadingWidget: _buildLoadingIndicator(isDarkMode),
        everythingLoaded: _everyThingLoaded || widget.children.length < widget.position,
        children: widget.children,
      );
    }
  }

  Widget _buildLoadingIndicator(bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            valueColor: AlwaysStoppedAnimation<Color>(
              isDarkMode ? Colors.white70 : PoimenTheme.brand,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _loadMoreItems(String churchLevel, bool isDarkMode) async {
    FetchMoreOptions opts = FetchMoreOptions(
      variables: {'first': 12, 'after': widget.position}, // Increased page size
      updateQuery: ((previousResultData, fetchMoreResultData) {
        final church = ChurchForPaginatedMemberList.fromJson(fetchMoreResultData?[churchLevel][0]);
        final previousChurchData =
            ChurchForPaginatedMemberList.fromJson(previousResultData?[churchLevel][0]);

        bool? done;
        if (widget.category == MemberCategory.Sheep) {
          done = (previousChurchData.sheepPaginated!.position >=
              previousChurchData.sheepPaginated!.totalCount);
          final List<dynamic> sheep = [
            ...previousResultData?[churchLevel][0]['sheepPaginated']?['edges'] ?? [],
            ...fetchMoreResultData?[churchLevel][0]['sheepPaginated']?['edges'] ?? []
          ];
          fetchMoreResultData?[churchLevel][0]['sheepPaginated']?['edges'] = sheep;

          done = (church.sheepPaginated!.position >= church.sheepPaginated!.totalCount);
        }

        if (widget.category == MemberCategory.Goat) {
          done = (previousChurchData.goatsPaginated!.position >=
              previousChurchData.goatsPaginated!.totalCount);
          final List<dynamic> goats = [
            ...previousResultData?[churchLevel][0]['goatsPaginated']?['edges'] ?? [],
            ...fetchMoreResultData?[churchLevel][0]['goatsPaginated']?['edges'] ?? []
          ];

          fetchMoreResultData?[churchLevel][0]['goatsPaginated']?['edges'] = goats;

          done = (church.goatsPaginated!.position >= church.goatsPaginated!.totalCount);
        }

        if (widget.category == MemberCategory.Deer) {
          done = (previousChurchData.deerPaginated!.position >=
              previousChurchData.deerPaginated!.totalCount);
          final List<dynamic> deer = [
            ...previousResultData?[churchLevel][0]['deerPaginated']?['edges'] ?? [],
            ...fetchMoreResultData?[churchLevel][0]['deerPaginated']?['edges'] ?? []
          ];

          fetchMoreResultData?[churchLevel][0]['deerPaginated']?['edges'] = deer;
          done = (church.deerPaginated!.position >= church.deerPaginated!.totalCount);
        }

        if (done == true) {
          setState(() {
            _everyThingLoaded = true;
          });
        }

        return fetchMoreResultData;
      }),
    );

    await widget.fetchMore(opts);
  }
}

class InfiniteScrollGrid extends StatefulWidget {
  final Function(int page) onLoadingStart;
  final Widget loadingWidget;
  final bool everythingLoaded;
  final List<Widget> children;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final SliverGridDelegate gridDelegate;

  const InfiniteScrollGrid({
    Key? key,
    required this.onLoadingStart,
    required this.loadingWidget,
    required this.everythingLoaded,
    required this.children,
    required this.gridDelegate,
    this.physics,
    this.padding,
  }) : super(key: key);

  @override
  State<InfiniteScrollGrid> createState() => _InfiniteScrollGridState();
}

class _InfiniteScrollGridState extends State<InfiniteScrollGrid> {
  ScrollController scrollController = ScrollController();
  bool isLoading = false;
  int page = 0;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      _loadMore();
    }
  }

  void _loadMore() {
    if (!isLoading && !widget.everythingLoaded) {
      setState(() {
        isLoading = true;
        page++;
      });
      widget.onLoadingStart(page).then((_) {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      physics: widget.physics,
      padding: widget.padding,
      gridDelegate: widget.gridDelegate,
      itemCount: widget.children.length + (isLoading && !widget.everythingLoaded ? 3 : 0),
      itemBuilder: (context, index) {
        if (index < widget.children.length) {
          return widget.children[index];
        } else {
          return widget.loadingWidget;
        }
      },
    );
  }
}
