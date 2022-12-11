import 'dart:collection';
import 'dart:core';
import 'Head.dart';

class Tail {
  int x = 0;
  int y = 0;
  HashSet<String> visitedPositions = HashSet();

  int distanceToHead(Head head) {
    int dx = head.x - x;
    int dy = head.y - y;
    return dx.abs() + dy.abs();
  }

  Tail() {
    this.visitedPositions.add("0:0");
  }

  void moveToHead(Head head) {
    int distance = distanceToHead(head);
    if (distance < 2) return;

    // If head and tail are on the same axis (x or y) and the distance is 2, move the tail towards the head on that axis
    int dx = head.x - x;
    int dy = head.y - y;
    if ((distance == 2 && (dx == 0 || dy == 0)) || distance > 2) {
      x += dx.sign;
      y += dy.sign;
      visitedPositions.add("${x}:${y}");
      return;
    }
  }
}
