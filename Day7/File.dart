class File {
  String name = "";
  int size = 0;

  File(String line) {
    int startOfFileName = line.indexOf(" ") + 1;
    this.size = int.parse(line.substring(0, startOfFileName - 1));
    this.name = line.substring(startOfFileName, line.length);
  }
}
