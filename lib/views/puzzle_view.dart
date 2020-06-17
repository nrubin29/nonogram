import 'package:flutter/material.dart';
import 'package:nonogram/components/cell_component.dart';
import 'package:nonogram/components/puzzle_component.dart';
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

    return Center(
        child: Container(
            padding: EdgeInsets.all(10),
            child: Column(children: [
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
              PuzzleComponent(puzzle: puzzle)
            ])));
  }
}
