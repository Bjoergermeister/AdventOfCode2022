import 'dart:io';
import 'dart:math';

late final int gridWidth;
late final int gridHeight;
late final List<int> grid;
int highestScenicScore = -1;

void parseInput(List<String> lines) {
  grid = List.filled(gridWidth * gridHeight, 0);
  for (int y = 0; y < lines.length; y++) {
    for (int x = 0; x < lines[0].length; x++) {
      grid[y * gridWidth + x] = int.parse(lines[y][x]);
    }
  }
}

bool isVisible(int x, int y) {
  List<bool> directions = List.filled(4, true);
  int treeHeight = grid[y * gridWidth + x];
  // Check from top
  for (int dy = 0; dy < y; dy++) {
    if (grid[dy * gridWidth + x] >= treeHeight) {
      directions[0] = false;
      break;
    }
  }

  // Check from bottom
  for (int dy = y + 1; dy < gridHeight; dy++) {
    if (grid[dy * gridWidth + x] >= treeHeight) {
      directions[1] = false;
      break;
    }
  }

  // Check from left
  for (int dx = 0; dx < x; dx++) {
    if (grid[y * gridWidth + dx] >= treeHeight) {
      directions[2] = false;
      break;
    }
  }

  // Check from right
  for (int dx = x + 1; dx < gridWidth; dx++) {
    if (grid[y * gridWidth + dx] >= treeHeight) {
      directions[3] = false;
      break;
    }
  }

  return directions.any((element) => element);
}

void scenicScore(int x, int y) {
  int treeHeight = grid[y * gridWidth + x];
  List<int> scenicScore = [y, gridHeight - y - 1, x, gridWidth - x - 1];
  // Top
  for (int dy = y - 1; dy >= 0; dy--) {
    if (grid[dy * gridWidth + x] >= treeHeight) {
      scenicScore[0] = y - dy;
      break;
    }
  }

  // Bottom
  for (int dy = y + 1; dy < gridHeight; dy++) {
    if (grid[dy * gridWidth + x] >= treeHeight) {
      scenicScore[1] = dy - y;
      break;
    }
  }

  // Left
  for (int dx = x - 1; dx >= 0; dx--) {
    if (grid[y * gridWidth + dx] >= treeHeight) {
      scenicScore[2] = x - dx;
      break;
    }
  }

  // Right
  for (int dx = x + 1; dx < gridWidth; dx++) {
    if (grid[y * gridWidth + dx] >= treeHeight) {
      scenicScore[3] = dx - x;
      break;
    }
  }

  int total = scenicScore.fold(1, ((previous, current) => previous * current));
  highestScenicScore = max(total, highestScenicScore);
}

int puzzle1() {
  // Trees on the edge are always visible and don't need to be checked
  int visibleTrees = (gridHeight * 2) + ((gridWidth - 2) * 2);

  for (int x = 1; x < gridWidth - 1; x++) {
    for (int y = 1; y < gridHeight - 1; y++) {
      scenicScore(x, y);
      if (isVisible(x, y) == false) continue;
      visibleTrees++;
    }
  }
  return visibleTrees;
}

void main() {
  File file = File("input.txt");
  List<String> lines = file.readAsLinesSync();

  gridWidth = lines[0].length;
  gridHeight = lines.length;

  parseInput(lines);

  print("Puzzle 1: ${puzzle1()}");
  print("Puzzle 2: ${highestScenicScore}");
}
