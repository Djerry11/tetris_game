import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GridPixel extends StatelessWidget {
  GridPixel({super.key, this.color});

  Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: Colors.black,
          width: 0,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      // child: Center(child: Text(index.toString())),
    );
  }
}
