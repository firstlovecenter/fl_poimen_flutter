import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/screens/duties/imcl/models_imcl.dart';
import 'package:poimen/screens/duties/imcl/widget_imcl_report_form.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/services/cloudinary_service.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:poimen/widgets/avatar_with_initials.dart';
import 'package:poimen/widgets/icon_contact.dart';
import 'package:poimen/widgets/no_data.dart';
import 'package:provider/provider.dart';

class ChurchImclList extends StatefulWidget {
  const ChurchImclList({Key? key, required this.church}) : super(key: key);

  final ChurchForImclList church;

  @override
  ChurchImclListState createState() => ChurchImclListState();
}

class ChurchImclListState extends State<ChurchImclList> {
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive layout
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width >= 600 && screenSize.width < 900;
    final isDesktop = screenSize.width >= 900;

    // Check for dark mode
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    // Define colors based on theme
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final cardColor = isDarkMode ? PoimenTheme.darkCardColor : Colors.white;
    final searchBgColor = isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100;

    // Calculate content width for better readability on larger screens
    final double contentMaxWidth = isDesktop
        ? 900
        : isTablet
            ? screenSize.width * 0.85
            : screenSize.width;

    final filteredList = widget.church.imcls
        .where((member) => '${member.firstName} ${member.lastName}'
            .toLowerCase()
            .contains(_searchText.toLowerCase()))
        .toList();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: contentMaxWidth),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header with explanation
                _buildHeader(isDarkMode, isTablet, isDesktop),

                const SizedBox(height: 16.0),

                // Search bar
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Search by member name',
                    prefixIcon: Icon(
                      FontAwesomeIcons.magnifyingGlass,
                      color: PoimenTheme.brand,
                      size: 16,
                    ),
                    filled: true,
                    fillColor: searchBgColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: PoimenTheme.brand, width: 1.5),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchText = value;
                    });
                  },
                ),

                const SizedBox(height: 16.0),

                // Member count indicator
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Text(
                    'Showing ${filteredList.length} of ${widget.church.imcls.length} members',
                    style: TextStyle(
                      color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),

                const SizedBox(height: 8.0),

                // Member list
                Expanded(
                  child: _buildMemberList(filteredList, cardColor, isDarkMode, isTablet, isDesktop),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDarkMode, bool isTablet, bool isDesktop) {
    final titleFontSize = isDesktop
        ? 22.0
        : isTablet
            ? 20.0
            : 18.0;
    final subtitleFontSize = isDesktop
        ? 16.0
        : isTablet
            ? 15.0
            : 14.0;

    return Card(
      elevation: isDarkMode ? 4.0 : 2.0,
      color: isDarkMode ? PoimenTheme.brand.withOpacity(0.15) : PoimenTheme.brand.withOpacity(0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(
          color:
              isDarkMode ? PoimenTheme.brand.withOpacity(0.3) : PoimenTheme.brand.withOpacity(0.1),
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(
              FontAwesomeIcons.userClock,
              color: PoimenTheme.brand,
              size: isDesktop ? 32.0 : 28.0,
            ),
            const SizedBox(height: 12.0),
            Text(
              'Members Who Missed Church',
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Contact them to find out why they were absent',
              style: TextStyle(
                fontSize: subtitleFontSize,
                fontWeight: FontWeight.w500,
                color: PoimenTheme.brand,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberList(
      List<ImclForList> members, Color cardColor, bool isDarkMode, bool isTablet, bool isDesktop) {
    if (members.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.peopleGroup,
              size: 48,
              color: isDarkMode ? Colors.grey.shade600 : Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'No members found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try adjusting your search',
              style: TextStyle(
                fontSize: 14,
                color: isDarkMode ? Colors.grey.shade500 : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      );
    }

    // Use a different layout approach for tablet and desktop
    if (isTablet || isDesktop) {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isDesktop ? 2 : 1,
          childAspectRatio: isDesktop ? 2.2 : 2.0,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: members.length,
        padding: const EdgeInsets.only(top: 8, bottom: 24),
        itemBuilder: (context, index) {
          return _memberTile(context, members[index], cardColor, isDarkMode, isTablet, isDesktop);
        },
      );
    }

    // Mobile layout
    return ListView.builder(
      itemCount: members.length,
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      itemBuilder: (context, index) {
        return _memberTile(context, members[index], cardColor, isDarkMode, isTablet, isDesktop);
      },
    );
  }
}

Widget _memberTile(BuildContext context, ImclForList member, Color cardColor, bool isDarkMode,
    bool isTablet, bool isDesktop) {
  CloudinaryImage picture = CloudinaryImage(url: member.pictureUrl, size: ImageSize.normal);
  var memberState = context.watch<SharedState>();

  return Card(
    elevation: isDarkMode ? 4.0 : 2.0,
    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
    color: cardColor,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: isTablet || isDesktop ? 8.0 : 6.0),
          onTap: () {
            memberState.memberId = member.id;
            memberState.member = member;
            Navigator.pushNamed(context, '/member-details');
          },
          leading: Hero(
            tag: 'member-${member.id}',
            child: AvatarWithInitials(
              foregroundImage: picture.image,
              member: member,
              radius: isTablet || isDesktop ? 28.0 : 24.0,
            ),
          ),
          title: Text(
            '${member.firstName} ${member.lastName}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: isTablet || isDesktop ? 16.0 : 15.0,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              member.status ?? 'Member',
              style: TextStyle(
                fontSize: isTablet || isDesktop ? 14.0 : 13.0,
                color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
              ),
            ),
          ),
          trailing: Wrap(
            spacing: 12.0,
            children: [
              ContactIcon(
                icon: Icons.phone,
                color: PoimenTheme.phoneColor,
                phoneNumber: member.phoneNumber,
              ),
              ContactIcon(
                icon: FontAwesomeIcons.whatsapp,
                color: PoimenTheme.whatsappColor,
                whatsAppInfo:
                    WhatsAppInfo(number: member.whatsappNumber, firstName: member.firstName),
              ),
            ],
          ),
        ),
        _buildImclStatus(context, member, isDarkMode, isTablet, isDesktop),
      ],
    ),
  );
}

Widget _buildImclStatus(
    BuildContext context, ImclForList member, bool isDarkMode, bool isTablet, bool isDesktop) {
  final horizontalPadding = isTablet || isDesktop ? 20.0 : 16.0;

  if (member.imclChecked) {
    return Container(
      margin: EdgeInsets.fromLTRB(horizontalPadding, 0, horizontalPadding, 16.0),
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color.fromARGB(130, 76, 175, 79).withOpacity(0.2)
            : const Color.fromARGB(130, 76, 175, 79).withOpacity(0.15),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: const Color.fromARGB(130, 76, 175, 79),
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  FontAwesomeIcons.circleCheck,
                  size: 14,
                  color: Color.fromARGB(255, 76, 175, 79),
                ),
                const SizedBox(width: 8),
                Text(
                  'Reason for absence:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              member.missedChurchComments[0].comment,
              style: TextStyle(
                fontSize: 15,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  } else {
    return Padding(
      padding: EdgeInsets.fromLTRB(horizontalPadding, 4.0, horizontalPadding, 16.0),
      child: ElevatedButton.icon(
        onPressed: () {
          _bottomSheet(context, member);
        },
        style: _imclButtonStyle(isDarkMode),
        icon: const Icon(
          FontAwesomeIcons.pencil,
          size: 14,
          color: Colors.white,
        ),
        label: const Text(
          'Submit Reason',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

ButtonStyle _imclButtonStyle(bool isDarkMode) {
  return ButtonStyle(
    padding: WidgetStateProperty.all(
      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    ),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
    backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
      if (states.contains(WidgetState.pressed)) {
        return isDarkMode ? PoimenTheme.brand.withOpacity(0.7) : PoimenTheme.brand.withOpacity(0.8);
      }
      return PoimenTheme.brand;
    }),
    elevation: WidgetStateProperty.all(isDarkMode ? 4.0 : 2.0),
  );
}

void _bottomSheet(BuildContext context, MemberForList member) {
  final mediaQuery = MediaQuery.of(context);
  final isDarkMode = mediaQuery.platformBrightness == Brightness.dark;

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
    ),
    isScrollControlled: true,
    backgroundColor: isDarkMode ? PoimenTheme.darkCardColor : Colors.white,
    elevation: 8,
    builder: (BuildContext context) {
      return IMCLReportForm(member: member);
    },
  );
}
