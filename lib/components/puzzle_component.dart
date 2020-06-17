import 'package:flutter/material.dart';
import 'package:nonogram/components/cell_component.dart';
import 'package:nonogram/util/nonogram.dart';

class PuzzleComponent extends StatelessWidget {
  final Nonogram puzzle;

  PuzzleComponent({Key key, @required this.puzzle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        defaultColumnWidth: FixedColumnWidth(CELL_SIZE),
        children: [
          ...puzzle.colCluesIterable.map((clueRow) => TableRow(children: [
                ...Iterable.generate(puzzle.maxNumRowClues, (_) => SizedBox()),
                ...clueRow
                    .map((clue) => clue == 0
                        ? SizedBox()
                        : Text(clue.toString(), textAlign: TextAlign.center))
                    .toList(growable: false)
              ])),
          ...puzzle.board
              .asMap()
              .entries
              .map((entry) => TableRow(children: [
                    ...puzzle.rowCluesIterable(entry.key).map((clue) => clue ==
                            0
                        ? SizedBox()
                        : Text(clue.toString(), textAlign: TextAlign.center)),
                    ...entry.value
                        .asMap()
                        .entries
                        .map((rowEntry) =>
                            CellComponent(row: entry.key, col: rowEntry.key))
                        .toList(growable: false)
                  ]))
              .toList(growable: false)
        ]);
  }
}
