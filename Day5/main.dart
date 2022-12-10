import 'dart:io';
import 'dart:math';

List<List<String>> parseInput(List<String> lines, int sectionDivider) {
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

  return stacks;
}

void moveSingle(int amount, List<String> source, List<String> destination) {
  // The top most item of the source stack gets moved to the destination stack.
  int actualAmount = min(amount, source.length);
  for (int j = actualAmount - 1; j >= 0; j--) {
    destination.add(source.removeLast());
  }
}

void moveBlock(int amount, List<String> source, List<String> destination) {
  int actualAmount = min(amount, source.length);
  for (int i = source.length - actualAmount; i < source.length; i++) {
    destination.add(source.elementAt(i));
  }
  source.removeRange(source.length - actualAmount, source.length);
}

String getAnswer(List<List<String>> stacks) {
  StringBuffer buffer = new StringBuffer();
  for (int i = 0; i < 9; i++) {
    buffer.write(stacks[i].last);
  }

  return buffer.toString();
}

String run(List<String> lines,
    Function(int, List<String>, List<String>) moveFunction) {
  // Index of line in input which divides the stacks and move instructions
  int sectionDivider = 0;
  while (lines[sectionDivider].length != 0) {
    sectionDivider++;
  }

  var stacks = parseInput(lines, sectionDivider);

  // Move item around
  for (int i = sectionDivider + 1; i < lines.length; i++) {
    List<String> parts = lines[i].split(" ");
    int amount = int.parse(parts[1]);
    int source = int.parse(parts[3]) - 1;
    int destination = int.parse(parts[5]) - 1;
    moveFunction(amount, stacks[source], stacks[destination]);
  }

  return getAnswer(stacks);
}

void main() {
  File file = File("input.txt");
  List<String> lines = file.readAsLinesSync();
  print("Puzzle 1: ${run(lines, moveSingle)}");
  print("Puzzle 2: ${run(lines, moveBlock)}");
}
