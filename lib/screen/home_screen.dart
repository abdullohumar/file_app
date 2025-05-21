import 'package:file_app/provider/file_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _fileNameController = TextEditingController();
  final _contentsController = TextEditingController();

  final _textStyle = const TextStyle(fontSize: 20);

  @override
  void dispose() {
    _fileNameController.dispose();
    _contentsController.dispose();
    super.dispose();
  }

  Future<String?> openListOfFileName() async {
    final fileProvider = context.read<FileProvider>();
    await fileProvider.getAllFilesInDirectory();
    final listOfFile = fileProvider.filesName;

    String? result;
    if (mounted) {
      result = await showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Select a file'),
            children:
                listOfFile
                    .map(
                      (file) => SimpleDialogOption(
                        onPressed: () {
                          Navigator.pop(context, file);
                        },
                        child: Text(file),
                      ),
                    )
                    .toList(),
          );
        },
      );
      return result;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('HomeScreen'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: _createNewFile,
                      child: Text('New File', style: _textStyle),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: _openFile,
                      child: Text('Open File', style: _textStyle),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: _saveFile,
                      child: Text('Save File', style: _textStyle),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _fileNameController,
                      style: _textStyle,
                      decoration: InputDecoration(hintText: 'file_name.txt'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void showSnackBar(String text) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    scaffoldMessenger.showSnackBar(SnackBar(content: Text(text)));
  }

  void _createNewFile() {
    _fileNameController.clear();
    _contentsController.clear();
    showSnackBar("New file created");
  }

  void _saveFile() async {
    final fileName = _fileNameController.text;
    final contents = _contentsController.text;

    if (fileName.isEmpty || contents.isEmpty) {
      showSnackBar("Please enter a file name and contents");
      return;
    }

    final fileProvider = context.read<FileProvider>();
    await fileProvider
        .saveFile(fileName, contents)
        .then((value) => showSnackBar(fileProvider.message))
        .catchError((error) => showSnackBar(fileProvider.message))
        .whenComplete(() {
          _fileNameController.clear();
          _contentsController.clear();
        });
  }

  void _openFile() async {
    final fileProvider = context.read<FileProvider>();
    final fileName = (await openListOfFileName()) ?? "";

    if (fileName.isNotEmpty) {
      await fileProvider.readFile(fileName);

      _fileNameController.text = fileName;
      _contentsController.text = fileProvider.contents ?? "";
      showSnackBar(fileProvider.message);
    }
  }
}
