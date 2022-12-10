import 'dart:collection';
import 'dart:io';

int run(String input, int tokenLength) {
  HashMap<int, int> characterAmounts = HashMap();
  for (int i = 0; i < input.length; i++) {
    int character = input.codeUnitAt(i);
    characterAmounts[character] = 1 + (characterAmounts[character] ?? 0);

    // If there are less than three computed characters, there is no need for further checks
    if (i <= tokenLength - 2) continue;

    if (characterAmounts.keys.every((key) => characterAmounts[key] == 1)) {
      return i + 1;
    }

    // Remove
    int removeIndex = input.codeUnitAt(i - (tokenLength - 1));
    characterAmounts[removeIndex] = (characterAmounts[removeIndex] ?? 0) - 1;
    if (characterAmounts[removeIndex] == 0) {
      characterAmounts.remove(removeIndex);
    }
  }
  return 0;
}

void main() {
  File file = File("input.txt");
  String line = file.readAsLinesSync()[0];
  print("Puzzle 1: ${run(line, 4)}");
  print("Puzzle 2: ${run(line, 14)}");
}
