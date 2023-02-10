import 'package:flutter/material.dart';
import 'package:poimen/screens/duties/visitation/widget_outstanding_visitation_list.dart';
import 'package:poimen/screens/membership/idl/models_idl.dart';
import 'package:poimen/widgets/no_data.dart';

class ChurchIdlList extends StatelessWidget {
  const ChurchIdlList({Key? key, required this.church}) : super(key: key);

  final ChurchForIdlList church;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        children: noDataChecker(church.idls.map((member) {
          return visitationMemberTile(context, member);
        }).toList()),
      ),
    );
  }
}
