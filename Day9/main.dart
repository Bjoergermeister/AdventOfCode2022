import 'dart:io';
import 'Knot.dart';

int run(List<String> lines, int knotCount) {
  List<Knot> knots = [];
  for (int i = 0; i < knotCount; i++) {
    knots.add(new Knot());
  }

  for (int i = 0; i < lines.length; i++) {
    String line = lines[i];
    int direction = line.codeUnitAt(0);
    int distance = int.parse(line.substring(2, line.length));

    for (int i = 0; i < distance; i++) {
      knots[0].move(direction);
      for (int j = 1; j < knotCount; j++) {
        knots[j].moveTowards(knots[j - 1]);
      }
    }
  }

  return knots[knots.length - 1].visitedPositions.length;
}

void main() {
  File file = File("input.txt");
  List<String> lines = file.readAsLinesSync();
  print("Puzzle 1: ${run(lines, 2)}");
  print("Puzzle 2: ${run(lines, 10)}");
}
