import 'dart:io';
import 'dart:math';

String puzzle1(List<String> lines) {
  // Index of line in input which divides the stacks and move instructions
  int sectionDivider = 0;
  while (lines[sectionDivider].length != 0) {
    sectionDivider++;
  }

  List<List<String>> stacks = [];
  for (int i = 0; i < sectionDivider; i++) {
    stacks.add([]);
  }

  // Parse input
  for (int j = 0; j < sectionDivider; j += 1) {
    int index = 1 + (4 * j);
    for (int i = sectionDivider - 2; i >= 0; i--) {
      String item = lines[i][index];
      if (item == " ") continue;

      stacks[j].add(lines[i][index]);
    }
  }

  // Move item around
  for (int i = sectionDivider + 1; i < lines.length; i++) {
    List<String> parts = lines[i].split(" ");
    int amount = int.parse(parts[1]);
    int source = int.parse(parts[3]) - 1;
    int destination = int.parse(parts[5]) - 1;

    // The top most item of the source stack gets moved to the destination stack.
    int actualAmount = min(amount, stacks[source].length);
    for (int j = actualAmount - 1; j >= 0; j--) {
      stacks[destination].add(stacks[source].removeLast());
    }
  }

  StringBuffer buffer = new StringBuffer();
  for (int i = 0; i < 9; i++) {
    buffer.write(stacks[i].last);
  }

  return buffer.toString();
}

void main() {
  File file = File("input.txt");
  List<String> lines = file.readAsLinesSync();
  print("Puzzle 1: ${puzzle1(lines)}");
}
