import "dart:io";

int run(List<String> lines, bool onlyCountWholeOverlapps) {
  int overlappingCount = 0;
  for (int i = 0; i < lines.length; i++) {
    List<int> elves = lines[i]
        .split(RegExp(r'[-,]'))
        .map((element) => int.parse(element))
        .toList();

    // Note: This is maybe not the most readable approach, but it should be the fastest and still easy enough to understand

    // Check if one range fully contains the other
    bool fullyContains = (elves[0] >= elves[2] && elves[1] <= elves[3] ||
        elves[2] >= elves[0] && elves[3] <= elves[1]);

    // Check if there is any overlapping between the ranges
    bool contains = (elves[0] >= elves[2] && elves[0] <= elves[3] ||
        elves[1] >= elves[2] && elves[1] <= elves[3] ||
        elves[2] >= elves[0] && elves[2] <= elves[1] ||
        elves[3] >= elves[0] && elves[3] <= elves[1]);

    if (fullyContains || (!onlyCountWholeOverlapps && contains)) {
      overlappingCount++;
    }
  }

  return overlappingCount;
}

void main() {
  File file = File("input.txt");
  List<String> lines = file.readAsLinesSync();

  print("Puzzle 1: ${run(lines, true)}");
  print("Puzzle 2: ${run(lines, false)}");
}
