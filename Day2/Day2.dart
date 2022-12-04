import "dart:io";

int puzzle1(List<String> lines) {
  List<int> playerWins = [12, 23, 31];
  int score = 0;

  for (int i = 0; i < lines.length; i++) {
    String line = lines[i];

    int opponent = line.codeUnitAt(0) - 64; // A = 1, B = 2, C = 3
    int me = line.codeUnitAt(2) - 87; // X = 1, Y = 2, Z = 3

    // draw
    int round = opponent * 10 + me; // This gives a unique value for each round

    int roundScore;
    if (opponent == me)
      roundScore = 3; //Draw
    else if (playerWins.contains(round))
      roundScore = 6;
    else
      roundScore = 0;

    score += (roundScore + me);
  }

  return score;
}

void main() {
  File file = File("input.txt");
  List<String> lines = file.readAsLinesSync();

  print("Puzzle1: ${puzzle1(lines)}");
}
