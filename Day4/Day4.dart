import 'dart:collection';
import "dart:io";

int run(List<String> lines, bool onlyCountWholeOverlapps) {
  int overlappingCount = 0;
  for (int i = 0; i < lines.length; i++) {
    List<int> elves = lines[i]
        .split(RegExp(r'[-,]'))
        .map((element) => int.parse(element))
        .toList();

    // Convert the ranges into HashSets and then compute the union to get the common elements
    HashSet<int> firstElve =
        HashSet.from([for (int i = elves[0]; i <= elves[1]; i++) i]);
    HashSet<int> secondElve =
        HashSet.from([for (int i = elves[2]; i <= elves[3]; i++) i]);
    HashSet<int> overlap = firstElve.intersection(secondElve) as HashSet<int>;

    // Check if the length of the union matches one of the ranges
    bool overlapsWholly = overlap.length == firstElve.length ||
        overlap.length == secondElve.length;
    if (overlapsWholly || (!onlyCountWholeOverlapps && overlap.length > 0)) {
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
