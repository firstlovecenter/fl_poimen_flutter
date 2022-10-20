import 'package:flutter/material.dart';
import 'package:poimen/screens/membership/models_membership.dart';
import 'package:poimen/theme.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({
    Key? key,
    this.church,
    required this.pageTitle,
  }) : super(key: key);

  final Church? church;
  final String pageTitle;

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    Widget title = Text(pageTitle);

    if (church != null) {
      title = Column(
        children: [
          Text(pageTitle),
          Text(
            '${church?.name} ${church?.typename}',
            style: TextStyle(
              fontSize: 15,
              color: isDarkMode ? PoimenTheme.brand : PoimenTheme.textSecondary,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      );
    }

    return title;
  }
}
