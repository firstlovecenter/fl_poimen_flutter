import 'package:flutter/material.dart';

List<Widget> noDataChecker(List<Widget> children) {
  if (children.isEmpty) {
    return [
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('There is no data to show'),
      ),
    ];
  } else {
    return children;
  }
}
