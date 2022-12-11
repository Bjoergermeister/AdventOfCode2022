import 'dart:io';
import 'Head.dart';
import 'Tail.dart';

int puzzle1(List<String> lines) {
  Head head = Head();
  Tail tail = Tail();

  for (int i = 0; i < lines.length; i++) {
    String line = lines[i];
    int direction = line.codeUnitAt(0);
    int distance = int.parse(line.substring(2, line.length));

    for (int i = 0; i < distance; i++) {
      head.move(direction);
      tail.moveToHead(head);
    }
  }

  return tail.visitedPositions.length;
}

void main() {
  File file = File("input.txt");
  List<String> lines = file.readAsLinesSync();
  print("Puzzle 1: ${puzzle1(lines)}");
}
