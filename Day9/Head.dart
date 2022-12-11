class Head {
  int x = 0;
  int y = 0;

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
}
