import 'dart:io';

List<int> run(List<String> lines) {
  List<int> topThreeElves = [0, 0, 0];
  int currentCalories = 0;

  // Append empty line so that the last group of calories gets evaluated properly
  lines.add("");

  for (var i = 0; i < lines.length; i++) {
    String line = lines[i];

    // If the line is empty, a new group of calories begins
    if (line.length == 0) {
      if (currentCalories > topThreeElves[0]) {
        topThreeElves.add(currentCalories);
        topThreeElves.sort();
        topThreeElves.removeAt(0);
      }

      currentCalories = 0;
      continue;
    }

    // Add calories up
    int calories = int.parse(line);
    currentCalories += calories;
  }

  return topThreeElves;
}

void main() {
  File file = File("input.txt");
  List<String> content = file.readAsLinesSync();

  List<int> topThreeElves = run(content);
  int sum = topThreeElves.fold(0, (previous, next) => previous + next);
  print("Puzzle 1: ${topThreeElves[2]}");
  print("Puzzle 2: $sum");
}
