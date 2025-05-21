import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class FileService{
  Future<String> getFilePath(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final prefixDirectory = directory.path;
    final absolutePath = path.join(prefixDirectory, fileName);
    return absolutePath;
  }

  Future<void> writeFile(String fileName, String contents) async {
    try {
      final filePath = await getFilePath(fileName);
      final file = File(filePath);
      await file.writeAsString(contents);
    } catch (e) {
      throw Exception("The file failed to be created");
    }
  }

  Future<String> readFile(String fileName) async {
    try {
      final filePath = await getFilePath(fileName);
      final file = File(filePath);

      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      throw Exception("The file failed to be opened");      
    }
  }

  Future<List<String>> getFilesInDirectory() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final files = directory.listSync().toList().where((file) => file.path.endsWith('.txt'));

      final filesName = files.map((file) => path.split(file.path).last).toList();
      return filesName;
    } catch (e) {
      throw Exception("Cannot read the entire file");
    }
  }
}