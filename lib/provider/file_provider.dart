import 'package:file_app/service/file_service.dart';
import 'package:flutter/widgets.dart';

class FileProvider extends ChangeNotifier {
  final FileService _service;
  FileProvider(this._service);

  String? _contents;

  String? get contents => _contents;

  String _message = "";

  String get message => _message;

  List<String> _filesName = [];

  List<String> get filesName => _filesName;

  Future<void> saveFile(String fileName, String contents) async {
    try {
      await _service.writeFile(fileName, contents);
      _message = "File saved successfully";
      notifyListeners();  
    } catch (e) {
      _message = e.toString();
      notifyListeners();
    }
  }

  Future<void> readFile(String fileName) async {
    try {
      _contents = await _service.readFile(fileName);
      notifyListeners();
    } catch (e) {
      _message = e.toString();
      notifyListeners();      
    }
  }

  Future<void> getAllFilesInDirectory() async {
    try {
      _filesName = await _service.getFilesInDirectory();
    } catch (e) {
      _message = e.toString();
      notifyListeners();      
    }
  }
}
