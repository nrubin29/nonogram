import 'dart:math';

import 'package:collection/collection.dart';
import 'package:nonogram/utils.dart';

class Nonogram {
  List<List<int>> _board;
  List<List<int>> _rowClues;
  List<List<int>> _colClues;

  Nonogram.generate(int rows, int cols, double density)
      : assert(rows > 0),
        assert(cols > 0),
        assert(0 < density && density < 1) {
    _board = Iterable.generate(rows,
            (_) => Iterable.generate(cols, (_) => 0).toList(growable: false))
        .toList(growable: false);

    final random = Random();
    var numCells = (rows * cols * density).floor();

    while (numCells > 0) {
      final row = random.nextInt(rows);
      final col = random.nextInt(cols);

      if (_board[row][col] == 0) {
        _board[row][col] = 1;
        numCells--;
      }
    }

    _rowClues = _board.map(getClues).toList(growable: false);
    _colClues = IterableZip(_board).map(getClues).toList(growable: false);
  }

  String _colCluesToString(int leftPadding) {
    final maxNumClues =
        maxBy<List<int>, int>(_colClues, (list) => list.length).length;

    return IterableZip(_colClues
            .map((e) => e.padLeft(maxNumClues, 0).map((e) => e == 0 ? ' ' : e)))
        .map((e) => ''.padLeft(leftPadding) + e.join(' '))
        .join('\n');
  }

  @override
  String toString() {
    final maxNumRowClues = maxBy(_rowClues, (list) => list.length).length;
    final showAnswer = false;

    return _colCluesToString(maxNumRowClues * 2 + 2) +
        '\n' +
        ''.padLeft(maxNumRowClues * 2 + 1) +
        ''.padLeft(_colClues.length * 2, '-') +
        '\n' +
        _board
            .asMap()
            .entries
            .map((entry) =>
                _rowClues[entry.key]
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
