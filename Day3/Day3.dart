import "dart:io";
import "dart:collection";

int puzzle1(List<String> lines) {
  int prioritySum = 0;
  for (int i = 0; i < lines.length; i++) {
    String line = lines[i];

    // Run through first compartment and save unique items in a HashSet
    HashSet<int> uniqueItems = HashSet();
    for (int j = 0; j < line.length ~/ 2; j++) {
      uniqueItems.add(line.codeUnitAt(j));
    }

    // Run through second compartment and work with first character that is in the HashSe
    for (int j = line.length ~/ 2; j < line.length; j++) {
      int character = line.codeUnitAt(j);
      if (uniqueItems.contains(character)) {
        // Uppercase is ASCII 65 - 90, Lowercase 97 - 122
        bool isLowercase = (character >= 97 && character <= 122);
        prioritySum += (isLowercase) ? character - 96 : character - (65 - 27);
        break;
      }
    }
  }

  return prioritySum;
}

void main() {
  File file = File("input.txt");
  List<String> lines = file.readAsLinesSync();

  print("Puzzle 1: ${puzzle1(lines)}");
}
