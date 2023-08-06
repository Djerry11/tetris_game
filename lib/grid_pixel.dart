import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GridPixel extends StatelessWidget {
  GridPixel({super.key, this.color});

  Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SizedBox(
        width: 50,
        height: 50,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
          ),
        ),
      ),

      // child: Center(child: Text(index.toString())),
    );
  }
}
