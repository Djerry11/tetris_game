import 'package:flutter/material.dart';

class BackBoard extends StatefulWidget {
  const BackBoard({super.key});

  @override
  State<BackBoard> createState() => _BackBoardState();
}

class _BackBoardState extends State<BackBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 10,
        ),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.grey[850],
              border: Border.all(
                color: Colors.black,
                width: 0,
              ),
            ),
            //child: Text(index.toString()),
          );
        },
      ),
    );
  }
}
