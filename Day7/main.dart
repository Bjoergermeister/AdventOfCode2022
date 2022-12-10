import 'dart:collection';
import 'dart:math';
import 'dart:io' as io;
import "File.dart";
import "Folder.dart";

HashMap<String, Folder> folders = HashMap();

void parseInput(List<String> lines) {
  Folder currentFolder = new Folder("/", null);
  folders["/"] = currentFolder;

  for (int i = 2; i < lines.length; i++) {
    String line = lines[i];

    if (line.startsWith("\$ ls"))
      continue;
    else if (line == "\$ cd ..") {
      // Change to parent folder
      currentFolder = currentFolder.parent!;
    } else if (line.startsWith("\$ cd")) {
      // Change to a subfolder
      int startOfFolderName = line.lastIndexOf(" ") + 1;
      String folderName = line.substring(startOfFolderName, line.length);
      currentFolder = folders["${currentFolder.getFullName()}/${folderName}"]!;
      continue;
    } else if (line.startsWith("dir")) {
      // Create a new folder
      Folder newFolder = Folder(line, currentFolder);
      currentFolder.subfolders.add(newFolder);
      folders[newFolder.getFullName()] = newFolder;
      continue;
    } else {
      // If its a file
      File file = File(line);
      currentFolder.files.add(file);
    }
  }
}

int puzzle1() {
  folders["/"]!.calculateSize();
  int totalSize = 0;
  folders.values.forEach(
      (folder) => {totalSize += (folder.size < 100000) ? folder.size : 0});

  return totalSize;
}

int puzzle2() {
  final int totalDiskSize = 70000000;
  final int freeDiskSize = totalDiskSize - folders["/"]!.size;
  final int missingSize = 30000000 - freeDiskSize;
  int size = folders.values
      .where((folder) => folder.size > missingSize)
      .map<int>((folder) => folder.size)
      .reduce(min);

  return size;
}

void main() {
  io.File file = io.File("input.txt");
  List<String> lines = file.readAsLinesSync();
  parseInput(lines);

  print("Puzzle 1: ${puzzle1()}");
  print("Puzzle 2: ${puzzle2()}");
}
