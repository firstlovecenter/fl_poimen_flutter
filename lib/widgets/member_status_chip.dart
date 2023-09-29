import 'package:flutter/material.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/theme.dart';

class MemberStatusChip extends StatelessWidget {
  const MemberStatusChip({
    super.key,
    required this.member,
  });

  final MemberForList member;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        member.status ?? 'No Status',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: member.status == 'Goat' ? Colors.black : Colors.white,
        ),
      ),
      backgroundColor: member.status == 'Sheep'
          ? PoimenTheme.good
          : member.status == 'Goat'
              ? PoimenTheme.warning
              : member.status == 'Deer'
                  ? PoimenTheme.brand
                  : PoimenTheme.bad,
    );
  }
}
