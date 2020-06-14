import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const CELL_SIZE = 24.0;

enum CellStatus { empty, filled, crossed }

CellStatus CELL_ACTION = CellStatus.filled;

class CellComponent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CellComponentState();
}

class _CellComponentState extends State<CellComponent> {
  CellStatus status = CellStatus.empty;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            status =
                status == CellStatus.empty ? CELL_ACTION : CellStatus.empty;
          });
        },
        child: SizedBox(
            width: CELL_SIZE,
            height: CELL_SIZE,
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 0.5),
                    color: status == CellStatus.filled
                        ? Colors.black
                        : status == CellStatus.crossed
                            ? Colors.grey.shade500
                            : Colors.white))));
  }
}
