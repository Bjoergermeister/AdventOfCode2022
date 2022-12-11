import 'dart:collection';
import 'dart:core';

class Knot {
  int x = 0;
  int y = 0;
  HashSet<String> visitedPositions = HashSet();

  Knot() {
    this.visitedPositions.add("0:0");
  }

  int distanceTo(Knot knot) {
    int dx = knot.x - x;
    int dy = knot.y - y;
    return dx.abs() + dy.abs();
  }

  void move(int direction) {
    switch (direction) {
      case 85: // 'U', up
        y--;
        break;
      case 76: // 'L', left
        x--;
        break;
      case 68: // 'D', down
        y++;
        break;
      case 82: // 'R', right
        x++;
        break;
      default:
        break;
    }
  }

  void moveTowards(Knot knot) {
    int distance = distanceTo(knot);
    if (distance < 2) return;

    // If head and tail are on the same axis (x or y) and the distance is 2, move the tail towards the head on that axis
    int dx = knot.x - x;
    int dy = knot.y - y;
    if ((distance == 2 && (dx == 0 || dy == 0)) || distance > 2) {
      x += dx.sign;
      y += dy.sign;
      visitedPositions.add("${x}:${y}");
      return;
    }
  }
}
