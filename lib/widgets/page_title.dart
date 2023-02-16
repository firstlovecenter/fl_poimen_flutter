import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poimen/screens/profile_choose/models_profile.dart';
import 'package:poimen/theme.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({
    Key? key,
    this.church,
    required this.pageTitle,
  }) : super(key: key);

  final ProfileChurch? church;
  final String pageTitle;

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    Widget title = ListTile(
        title: Text(
      pageTitle,
      style: const TextStyle(color: Colors.white),
    ));

    if (church != null) {
      title = ListTile(
        title: Text(pageTitle,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text(
          '${church?.name} ${church?.typename}',
          style: TextStyle(
            fontSize: 15,
            color: isDarkMode ? PoimenTheme.brandTextPrimary : PoimenTheme.textSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: ModalRoute.of(context)!.settings.name != '/search' &&
                ModalRoute.of(context)!.settings.name != '/home'
            ? InkWell(
                child: const Icon(FontAwesomeIcons.magnifyingGlass),
                onTap: () {
                  Navigator.pushNamed(context, '/search');
                },
              )
            : null,
      );
    }

    return title;
  }
}
