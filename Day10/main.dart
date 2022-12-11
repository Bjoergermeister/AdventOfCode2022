import 'dart:collection';
import "dart:io";
import 'dart:math';

StringBuffer crt = StringBuffer("");

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

    // Update CRT output
    List<int> pixelPositions = [x - 1, x, x + 1];
    String output = (pixelPositions.contains((cycle % 40) - 1)) ? "#" : ".";
    crt.write(output);

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
  print("Puzzle 2:");

  // Write CRT
  String crtOutput = crt.toString();
  print(crtOutput.substring(0, 39));
  print(crtOutput.substring(40, 79));
  print(crtOutput.substring(80, 119));
  print(crtOutput.substring(120, 159));
  print(crtOutput.substring(160, 199));
  print(crtOutput.substring(200, min(crtOutput.length, 239)));
}
