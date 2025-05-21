import 'package:flutter/material.dart';

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
                  Expanded(child: TextField(
                    controller: _fileNameController,
                    style: _textStyle,
                    decoration: InputDecoration(
                      hintText: 'file_name.txt',
                    ),
                  )),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _createNewFile() {}

  void _openFile() {}

  void _saveFile() {}
}
