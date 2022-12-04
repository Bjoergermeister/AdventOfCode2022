import "dart:io";

// These lists contain the values (1 = Rock, 2 = Paper, 3 = Scissor) I have to choose for each element
// depending on whether if have to win, draw or loose. The order is [lose, draw, win]
List<int> rock = [3, 1, 2];
List<int> paper = [1, 2, 3];
List<int> scissors = [2, 3, 1];

/// Returns the response I have to play depending on what the opponent played
int get_response(int opponent, int result) {
  if (opponent == 1) // Opponent played Rock
    return rock[result - 1];
  else if (opponent == 2) // Opponent played Paper
    return paper[result - 1];
  else // Opponent played Scissors
    return scissors[result - 1];
}

int run(List<String> lines, bool is_puzzle_2) {
  List<int> playerWins = [12, 23, 31];
  int score = 0;

  for (int i = 0; i < lines.length; i++) {
    String line = lines[i];

    int opponent = line.codeUnitAt(0) - 64; // A = 1, B = 2, C = 3
    int me = line.codeUnitAt(2) - 87; // X = 1, Y = 2, Z = 3
    me = (is_puzzle_2) ? get_response(opponent, me) : me;

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

  print("Puzzle 1: ${run(lines, false)}");
  print("Puzzle 2: ${run(lines, true)}");
}
