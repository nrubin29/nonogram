import 'dart:math';

import 'package:collection/collection.dart';
import 'package:nonogram/util/utils.dart';

class Nonogram {
  final int rows;
  final int cols;

  List<List<int>> board;
  List<List<int>> rowClues;
  List<List<int>> colClues;

  int maxNumRowClues;
  int maxNumColClues;

  Nonogram.generate(int rows, int cols, double density)
      : assert(rows > 0),
        assert(cols > 0),
        assert(0 < density && density < 1),
        this.rows = rows,
        this.cols = cols {
    board = Iterable.generate(rows,
            (_) => Iterable.generate(cols, (_) => 0).toList(growable: false))
        .toList(growable: false);

    final random = Random();
    var numCells = (rows * cols * density).floor();

    while (numCells > 0) {
      final row = random.nextInt(rows);
      final col = random.nextInt(cols);

      if (board[row][col] == 0) {
        board[row][col] = 1;
        numCells--;
      }
    }

    rowClues = board.map(getClues).toList(growable: false);
    colClues = IterableZip(board).map(getClues).toList(growable: false);

    maxNumRowClues =
        maxBy<List<int>, int>(rowClues, (list) => list.length).length;
    maxNumColClues =
        maxBy<List<int>, int>(colClues, (list) => list.length).length;
  }

  Iterable<int> rowCluesIterable(int i) =>
      rowClues[i].padLeft(maxNumRowClues, 0);

  Iterable<Iterable<int>> get colCluesIterable =>
      IterableZip(colClues.map((e) => e.padLeft(maxNumColClues, 0)));

  String _colCluesToString(int leftPadding) => IterableZip(colClues.map(
          (e) => e.padLeft(maxNumColClues, 0).map((e) => e == 0 ? ' ' : e)))
      .map((e) => ''.padLeft(leftPadding) + e.join(' '))
      .join('\n');

  @override
  String toString() {
    final showAnswer = false;

    return _colCluesToString(maxNumRowClues * 2 + 2) +
        '\n' +
        ''.padLeft(maxNumRowClues * 2 + 1) +
        ''.padLeft(colClues.length * 2, '-') +
        '\n' +
        board
            .asMap()
            .entries
            .map((entry) =>
                rowClues[entry.key]
                    .padLeft(maxNumRowClues, 0)
                    .map((e) => e == 0 ? ' ' : e)
                    .join(' ') +
                ' | ' +
                entry.value
                    .map((cell) => showAnswer ? cell == 1 ? '█' : 'x' : '☐')
                    .join(' '))
            .join('\n');
  }
}
