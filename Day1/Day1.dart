import 'dart:io';
import 'dart:math';

int puzzle1(List<String> lines) {
  int currentCalories = 0;
  int highestCalories = -1;

  // Append empty line so that the last group of calories gets evaluated properly
  lines.add("");

  for (var i = 0; i < lines.length; i++) {
    String line = lines[i];

    // If the line is empty, a new group of calories begins
    if (line.length == 0) {
      highestCalories = max(highestCalories, currentCalories);
      currentCalories = 0;
      continue;
    }

    // Add calories up
    int calories = int.parse(line);
    currentCalories += calories;
  }

  return highestCalories;
}

void main() {
  File file = File("input.txt");
  List<String> content = file.readAsLinesSync();

  print(puzzle1(content));
}
