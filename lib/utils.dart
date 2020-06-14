/// Generates the clues for row/column [span]. For example, if [span] is
/// [0, 1, 0, 1, 1], the clues will be [1, 2].
List<int> getClues(List<int> span) {
  final clues = <int>[];
  var currentClue = 0;

  for (var cell in span) {
    if (cell == 0 && currentClue > 0) {
      clues.add(currentClue);
      currentClue = 0;
    } else if (cell == 1) {
      currentClue += 1;
    }
  }

  if (currentClue > 0) {
    clues.add(currentClue);
  }

  return clues;
}

extension PadLeft<T> on Iterable<T> {
  /// Adds a [padLeft] function to Iterables that pads the Iterable on the left
  /// with [padding] until its length is [width]. This works the same as
  /// [String.padLeft].
  Iterable<T> padLeft(int width, [T padding]) {
    return Iterable.generate(width - length, (_) => padding).followedBy(this);
  }
}
