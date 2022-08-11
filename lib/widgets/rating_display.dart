import 'package:flutter/material.dart';

class RatingDisplay extends StatelessWidget {
  final double rating;
  final double size;

  const RatingDisplay({
    Key? key,
    required this.rating,
    this.size = 20.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('Star Ratings');
  }
}
