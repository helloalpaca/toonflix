import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  final num value;

  const Rating({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < value.toInt() ~/ 2) {
          return const Icon(
            Icons.star,
            color: Colors.yellow,
          );
        }
        if (index == value.toInt() ~/ 2 && value.toInt() % 2 == 1) {
          return const Icon(
            Icons.star_half,
            color: Colors.yellow,
          );
        } else {
          return Icon(Icons.star, color: Colors.black.withOpacity(0.6));
        }
      }),
    );
  }
}
