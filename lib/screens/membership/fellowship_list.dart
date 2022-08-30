import 'package:flutter/material.dart';
import 'package:poimen/state/user_state.dart';
import 'package:provider/provider.dart';

class FellowshipMembershipList extends StatelessWidget {
  const FellowshipMembershipList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userState = Provider.of<UserState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text('${userState.church.name} Fellowship'),
            const Text('Membership List'),
          ],
        ),
      ),
    );
  }
}
