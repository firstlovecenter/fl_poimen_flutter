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
    var userState = Provider.of<SharedState>(context);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          userState.church = church;
          userState.roleLevel = getChurchLevelFromAuth((AuthService.instance.idToken?.roles ?? []));

          if (church.typename == 'Fellowship') {
            userState.role = Role.leaderFellowship;
            userState.fellowshipId = church.id;
          } else if (church.typename == 'Bacenta') {
            userState.role = Role.leaderBacenta;
            userState.bacentaId = church.id;
          } else if (church.typename == 'Constituency') {
            userState.role = Role.leaderConstituency;
            userState.constituencyId = church.id;
          } else if (church.typename == 'Council') {
            userState.role = Role.leaderCouncil;
            userState.councilId = church.id;
          } else if (church.typename == 'Stream') {
            userState.role = Role.leaderStream;
            userState.streamId = church.id;
          } else if (church.typename == 'GatheringService') {
            userState.role = Role.leaderGathering;
            userState.gatheringId = church.id;
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
    case 'GatheringService':
      return 'assets/images/profile-choose/gathering-admin.jpg';

    default:
  }
}
