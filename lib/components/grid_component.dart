import 'package:flutter/material.dart';
import 'package:nonogram/components/cell_component.dart';
import 'package:nonogram/util/nonogram.dart';

class GridComponent extends StatelessWidget {
  final Nonogram puzzle;

  GridComponent({Key key, @required this.puzzle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
        columnWidths: Map.fromIterable(Iterable.generate(puzzle.rows),
            key: (i) => i, value: (_) => FixedColumnWidth(CELL_SIZE)),
        children: Iterable.generate(
            puzzle.rows,
            (_) => TableRow(
                children: Iterable.generate(puzzle.cols, (_) => CellComponent())
                    .toList(growable: false))).toList(growable: false));
  }
}
