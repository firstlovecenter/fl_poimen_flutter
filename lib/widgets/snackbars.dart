import 'package:flutter/material.dart';

class ToastSnackbar {
  static SnackBar create(BuildContext context, {required String message, required IconData icon}) {
    return SnackBar(
      width: 200,
      backgroundColor: Theme.of(context).cardColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      duration: const Duration(seconds: 2),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Theme.of(context).hintColor,
          ),
          const Padding(padding: EdgeInsets.all(5)),
          Text(
            message,
            style: TextStyle(color: Theme.of(context).hintColor),
          ),
        ],
      ),
    );
  }
}
