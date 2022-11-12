import 'package:flutter/material.dart';
import 'package:poimen/theme.dart';

class ColorBlockTile extends StatelessWidget {
  ColorBlockTile(
      {Key? key,
      required this.leadingColor,
      this.color,
      required this.icon,
      required this.title,
      this.subtitle,
      this.to})
      : super(key: key);

  final Color leadingColor;
  Color? color;
  final IconData icon;
  final String title;
  String? subtitle;
  String? to;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, to ?? '');
      },
      contentPadding: const EdgeInsets.only(left: 0.0),
      leading: SizedBox(
        width: 55,
        child: Container(
          color: leadingColor,
          child: Center(
            child: Icon(
              icon,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      tileColor: color ?? PoimenTheme.darkCardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(5.0),
          bottomRight: Radius.circular(5.0),
        ),
      ),
    );
  }
}
