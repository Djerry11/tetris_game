import 'package:flutter/material.dart';

class Pixel extends StatelessWidget {
  const Pixel({super.key, required this.colors});
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: colors[0],
              borderRadius: const BorderRadius.all(Radius.circular(2)),
              border: Border.all(
                color: colors[1],
                width: 1,
              ),
            ),
          ),
          Container(
            width: 11,
            height: 11,
            decoration: BoxDecoration(
              color: colors[1],
              borderRadius: const BorderRadius.all(Radius.circular(2)),
            ),
          ),
        ],
      ),
    );
  }
}
