import 'package:flutter/material.dart';

class GridPixel extends StatelessWidget {
  GridPixel({super.key, this.color, this.index});
  var color;
  var index;

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
      child: Center(child: Text(index.toString())),
    );
  }
}
