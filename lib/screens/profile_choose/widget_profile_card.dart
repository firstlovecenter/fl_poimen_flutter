import 'package:flutter/material.dart';
import 'package:poimen/screens/profile_choose/models_profile.dart';
import 'package:poimen/services/auth_service.dart';
import 'package:poimen/state/enums.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:poimen/theme.dart';
import 'package:provider/provider.dart';

class ProfileCard extends StatelessWidget {
  final ProfileChurch church;
  final String role;
  final double? maxWidth;

  const ProfileCard({
    Key? key,
    required this.church,
    required this.role,
    this.maxWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userState = context.watch<SharedState>();
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    // Calculate responsive avatar size based on available width
    final double avatarSize = maxWidth != null ? (maxWidth! * 0.35).clamp(45.0, 70.0) : 60.0;

    return SizedBox(
      width: maxWidth,
      height: maxWidth,
      child: Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: _getRoleColor(church.typename).withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            userState.church = church;
            userState.roleLevel =
                getChurchLevelFromAuth((AuthService.instance.profile?.roles ?? []));
            userState.roleType = convertToRoleEnum(role);

            if (church.typename == 'Fellowship') {
              userState.role = getRoleEnum(ChurchLevel.fellowship, convertToRoleEnum(role));
              userState.fellowshipId = church.id;
            } else if (church.typename == 'Bacenta') {
              userState.role = getRoleEnum(ChurchLevel.bacenta, convertToRoleEnum(role));
              userState.bacentaId = church.id;
            } else if (church.typename == 'Governorship') {
              userState.role = getRoleEnum(ChurchLevel.governorship, convertToRoleEnum(role));
              userState.governorshipId = church.id;
            } else if (church.typename == 'Council') {
              userState.role = getRoleEnum(ChurchLevel.council, convertToRoleEnum(role));
              userState.councilId = church.id;
            } else if (church.typename == 'Stream') {
              userState.role = getRoleEnum(ChurchLevel.stream, convertToRoleEnum(role));
              userState.streamId = church.id;
            } else if (church.typename == 'Campus') {
              userState.role = getRoleEnum(ChurchLevel.campus, convertToRoleEnum(role));
              userState.campusId = church.id;
            } else if (church.typename == 'Hub') {
              userState.role = getRoleEnum(ChurchLevel.hub, convertToRoleEnum(role));
              userState.hubId = church.id;
            } else if (church.typename == 'HubCouncil') {
              userState.role = getRoleEnum(ChurchLevel.hubCouncil, convertToRoleEnum(role));
              userState.hubCouncilId = church.id;
            } else if (church.typename == 'Ministry') {
              userState.role = getRoleEnum(ChurchLevel.ministry, convertToRoleEnum(role));
              userState.ministryId = church.id;
            } else if (church.typename == 'CreativeArts') {
              userState.role = getRoleEnum(ChurchLevel.creativeArts, convertToRoleEnum(role));
              userState.creativeArtsId = church.id;
            }

            Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Role badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getRoleColor(church.typename).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${church.typename} $role',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: _getRoleColor(church.typename),
                    ),
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 8),
                // Avatar
                Container(
                  height: avatarSize,
                  width: avatarSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        _getRoleColor(church.typename).withOpacity(0.7),
                        _getRoleColor(church.typename).withOpacity(0.4),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _getRoleColor(church.typename).withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    foregroundImage: AssetImage(_getRoleImage(church.typename)),
                    child: Icon(
                      _getRoleIcon(church.typename),
                      color: Colors.white.withOpacity(0.9),
                      size: avatarSize * 0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Church name
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    church.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: isDarkMode ? Colors.white.withOpacity(0.9) : Colors.black87,
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

  Color _getRoleColor(String level) {
    switch (level) {
      case 'Fellowship':
        return Colors.green;
      case 'Bacenta':
        return Colors.blue;
      case 'Governorship':
        return Colors.purple;
      case 'Council':
        return Colors.orange;
      case 'Stream':
        return Colors.deepOrange;
      case 'Campus':
        return PoimenTheme.brand;
      case 'Hub':
        return Colors.teal;
      case 'Ministry':
        return Colors.indigo;
      case 'CreativeArts':
        return Colors.pink;
      default:
        return PoimenTheme.brand;
    }
  }

  IconData _getRoleIcon(String level) {
    switch (level) {
      case 'Fellowship':
        return Icons.people;
      case 'Bacenta':
        return Icons.home;
      case 'Governorship':
        return Icons.account_balance;
      case 'Council':
        return Icons.corporate_fare;
      case 'Stream':
        return Icons.water;
      case 'Campus':
        return Icons.school;
      case 'Hub':
        return Icons.hub;
      case 'Ministry':
        return Icons.church;
      case 'CreativeArts':
        return Icons.brush;
      default:
        return Icons.group;
    }
  }
}

_getRoleImage(String level) {
  switch (level) {
    case 'Fellowship':
      return 'assets/images/profile-choose/fellowship-leader.jpg';
    case 'Bacenta':
      return 'assets/images/profile-choose/bacenta-leader.jpg';
    case 'Governorship':
      return 'assets/images/profile-choose/governorship-leader.jpg';
    case 'Council':
      return 'assets/images/profile-choose/council-leader.jpeg';
    case 'Stream':
      return 'assets/images/profile-choose/council-leader.jpeg';
    case 'Campus':
      return 'assets/images/profile-choose/campus-admin.jpg';
    default:
      return 'assets/images/profile-choose/campus-admin.jpg';
  }
}
