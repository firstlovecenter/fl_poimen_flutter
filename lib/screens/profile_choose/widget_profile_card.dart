import 'package:flutter/material.dart';
import 'package:poimen/screens/profile_choose/models_profile.dart';
import 'package:poimen/services/auth_service.dart';
import 'package:poimen/state/enums.dart';
import 'package:poimen/state/shared_state.dart';
import 'package:provider/provider.dart';

class ProfileCard extends StatelessWidget {
  final ProfileChurch church;
  final String role;
  const ProfileCard({Key? key, required this.church, required this.role}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userState = context.watch<SharedState>();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          userState.church = church;
          userState.roleLevel = getChurchLevelFromAuth((AuthService.instance.idToken?.roles ?? []));
          userState.roleType = convertToRoleEnum(role);

          if (church.typename == 'Fellowship') {
            userState.role = getRoleEnum(ChurchLevel.fellowship, convertToRoleEnum(role));
            userState.fellowshipId = church.id;
          } else if (church.typename == 'Bacenta') {
            userState.role = getRoleEnum(ChurchLevel.bacenta, convertToRoleEnum(role));
            userState.bacentaId = church.id;
          } else if (church.typename == 'Constituency') {
            userState.role = getRoleEnum(ChurchLevel.constituency, convertToRoleEnum(role));
            userState.constituencyId = church.id;
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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${church.typename} $role',
                overflow: TextOverflow.fade,
                softWrap: false,
              ),
              const Padding(padding: EdgeInsets.all(8.0)),
              SizedBox(
                height: 69,
                width: 69,
                child: CircleAvatar(
                  foregroundImage: AssetImage(_getRoleImage(church.typename)),
                ),
              ),
              const Padding(padding: EdgeInsets.all(8.0)),
              Text(church.name, overflow: TextOverflow.fade, softWrap: false),
            ],
          ),
        ),
      ),
    );
  }
}

_getRoleImage(String level) {
  switch (level) {
    case 'Fellowship':
      return 'assets/images/profile-choose/fellowship-leader.jpg';
    case 'Bacenta':
      return 'assets/images/profile-choose/bacenta-leader.jpg';
    case 'Constituency':
      return 'assets/images/profile-choose/constituency-leader.jpg';
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
