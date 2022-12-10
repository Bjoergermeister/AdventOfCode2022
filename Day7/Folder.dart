import 'File.dart';

class Folder {
  String name = "";
  String path = "";
  int size = 0;
  Folder? parent;
  List<Folder> subfolders = [];
  List<File> files = [];

  Folder(String line, Folder? parent) {
    int startOfFolderName = line.indexOf(" ") + 1;
    this.name = line.substring(startOfFolderName, line.length);

    this.parent = parent;
    this.path = (parent != null) ? "${parent.getFullName()}" : "";
  }

  calculateSize() {
    for (int i = 0; i < subfolders.length; i++) {
      subfolders[i].calculateSize();
      size += subfolders[i].size;
    }

    for (int i = 0; i < files.length; i++) {
      size += files[i].size;
    }
  }

  String getFullName() {
    return (parent != null) ? "${this.path}/${this.name}" : "";
  }
}
