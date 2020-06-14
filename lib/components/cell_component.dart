import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const CELL_SIZE = 24.0;

class CellComponent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CellComponentState();
}

class _CellComponentState extends State<CellComponent> {
  bool filled = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            filled = !filled;
          });
        },
        child: SizedBox(
            width: CELL_SIZE,
            height: CELL_SIZE,
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 0.5),
                    color: filled ? Colors.black : Colors.white))));
  }
}
