import 'package:flutter/material.dart';
import 'package:nonogram/components/cell_component.dart';
import 'package:nonogram/components/grid_component.dart';
import 'package:nonogram/util/nonogram.dart';

class PuzzleView extends StatefulWidget {
  final Nonogram _puzzle;

  PuzzleView({Key key})
      : _puzzle = Nonogram.generate(10, 10, 0.5),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _PuzzleViewState();
}

class _PuzzleViewState extends State<PuzzleView> {
  Nonogram get puzzle => widget._puzzle;

  @override
  Widget build(BuildContext context) {
    print('\n$puzzle');

    return Column(children: [
      RaisedButton(
          child: Text('Fill'),
          onPressed: () {
            setState(() {
              CELL_ACTION = CellStatus.filled;
            });
          }),
      RaisedButton(
          child: Text('Cross'),
          onPressed: () {
            setState(() {
              CELL_ACTION = CellStatus.crossed;
            });
          }),
      SizedBox(height: 10),
      Row(children: [
        Column(children: [
          SizedBox(height: CELL_SIZE * 0.75 * puzzle.maxNumColClues - 5),
          Column(
              children: puzzle.board
                  .asMap()
                  .entries
                  .map((entry) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                          children: puzzle
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
              children: puzzle.colCluesIterable
                  .map((clueRow) => Row(
                      children: clueRow
                          .map((clue) => Padding(
                              padding: EdgeInsets.symmetric(horizontal: 7.5),
                              child: clue == 0
                                  ? SizedBox(width: 9)
                                  : Text(clue.toString())))
                          .toList(growable: false)))
                  .toList(growable: false)),
          GridComponent(puzzle: puzzle)
        ])
      ])
    ]);
  }
}
