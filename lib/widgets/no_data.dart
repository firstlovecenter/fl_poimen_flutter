import 'package:flutter/material.dart';

List<Widget> noDataChecker(List<Widget> children) {
  if (children.isEmpty) {
    return [
      const Card(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'There is no data to show',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    ];
  } else {
    return children;
  }
}
