import 'dart:collection';
import "dart:io";

int puzzle1(List<String> lines) {
  HashMap<int, int> valuesAfterCycle = HashMap();
  Set<int> cyclesOfInterest = {20, 60, 100, 140, 180, 220};

  int sumOfCycleStrenghs = 0;
  int x = 1;
  int cycle = 0;
  int lineIndex = 0;
  while (lineIndex < lines.length || valuesAfterCycle.length > 0) {
    cycle++;

    // If this cycle is interesting, update the sum of cycle strenghts
    if (cyclesOfInterest.contains(cycle)) {
      sumOfCycleStrenghs += x * cycle;
    }

    // if no instruction is currently executed, preprare execution of next instruction
    if (valuesAfterCycle.length == 0) {
      String line = lines[lineIndex];
      lineIndex++;
      if (line == "noop") continue;
      int change = int.parse(line.substring(5, line.length));
      valuesAfterCycle[cycle + 1] = x + change;
    }

    // If an instruction finishes in this cylce, update the registers
    if (valuesAfterCycle.containsKey(cycle)) {
      x = valuesAfterCycle[cycle]!;
      valuesAfterCycle.remove(cycle);
    }
  }

  return sumOfCycleStrenghs;
}

void main() {
  File file = File("input.txt");
  List<String> lines = file.readAsLinesSync();
  print("Puzzle 1: ${puzzle1(lines)}");
}
