import 'package:flutter/material.dart';
import 'package:nonogram/components/cell_component.dart';
import 'package:nonogram/components/grid_component.dart';
import 'package:nonogram/util/nonogram.dart';

class PuzzleView extends StatelessWidget {
  final Nonogram _puzzle;

  PuzzleView({Key key})
      : _puzzle = Nonogram.generate(10, 10, 0.5),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    print('\n$_puzzle');

    return Row(children: [
      Column(children: [
        SizedBox(height: CELL_SIZE * 0.75 * _puzzle.maxNumColClues - 5),
        Column(
            children: _puzzle.board
                .asMap()
                .entries
                .map((entry) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                        children: _puzzle
                            .rowCluesIterable(entry.key)
                            .map((e) => Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2),
                                child: e == 0
                                    ? SizedBox(width: 9)
                                    : Text(e.toString())))
                            .toList(growable: false))))
                .toList(growable: false))
      ]),
      Column(children: [
        Column(
            children: _puzzle.colCluesIterable
                .map((clueRow) => Row(
                    children: clueRow
                        .map((clue) => Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.5),
                            child: clue == 0
                                ? SizedBox(width: 9)
                                : Text(clue.toString())))
                        .toList(growable: false)))
                .toList(growable: false)),
        GridComponent(puzzle: _puzzle)
      ])
    ]);
  }
}
