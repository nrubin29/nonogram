import 'package:flutter/material.dart';
import 'package:nonogram/util/nonogram.dart';

class PuzzleView extends StatelessWidget {
  final Nonogram _puzzle;

  PuzzleView({Key key})
      : _puzzle = Nonogram.generate(10, 10, 0.5),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(children: [
      ..._puzzle.colCluesIterable.map((clueRow) => TableRow(children: [
            ...Iterable.generate(_puzzle.maxNumRowClues + 1, (_) => SizedBox()),
            ...clueRow
                .map((clue) => clue == 0 ? SizedBox() : Text(clue.toString()))
                .toList(growable: false)
          ])),
      TableRow(children: [
        ...Iterable.generate(_puzzle.maxNumRowClues + 1, (_) => SizedBox()),
        ...Iterable.generate(_puzzle.cols, (_) => Text('-'))
            .toList(growable: false)
      ]),
      ..._puzzle.board
          .asMap()
          .entries
          .map((entry) => TableRow(children: [
                ..._puzzle
                    .rowCluesIterable(entry.key)
                    .map((e) => e == 0 ? SizedBox() : Text(e.toString())),
                Text('|'),
                ...entry.value
                    .map((cell) => Text(cell.toString()))
                    .toList(growable: false)
              ]))
          .toList(growable: false)
    ]);
  }
}
