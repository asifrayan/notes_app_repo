import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';
import '../provider/notes_provider.dart';
import '../utility/constants.dart';

class NoteEditScreen extends StatefulWidget {
  static const routeName = '/note-edit';

  @override
  _NoteEditScreenState createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  TextEditingController _titleController;
  TextEditingController _descController;
  bool firstTime = true;
  Note selectedNote;
  int id;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (firstTime) {
      id = ModalRoute.of(this.context).settings.arguments;
      if (id != null) {
        selectedNote = Provider.of<NotesProvider>(this.context, listen: false)
            .getNoteById(id);
        _titleController.text = selectedNote?.title;
        _descController.text = selectedNote?.description;
      }
      firstTime = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          actions: [
            // IconButton(
            //   icon: Icon(Icons.save),
            //   onPressed: () {
            //     _saveNote();
            //   },
            // ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: FlatButton(
                textColor: Colors.white,
                color: Color(0xFF646464),
                child: const Text('Save'),
                onPressed: () {
                  _saveNote();
                },
              ),
            )
          ],
        ),
        body: _buildInputFields(),
      ),
    );
  }

  Widget _buildInputFields() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              controller: _titleController,
              style: TextStyle(fontSize: 20),
              keyboardType: TextInputType.multiline,
              maxLines: 2,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Title',
                hintStyle: TextStyle(fontSize: 28),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
              controller: _descController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Type something ...',
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _saveNote() {
    FocusScope.of(context).unfocus();

    String title = _titleController.text.trim();
    if (title.isEmpty) {
      return;
    }
    String description = _descController.text.trim();

    if (id != null) {
      Provider.of<NotesProvider>(this.context, listen: false)
          .addOrUpdateNote(id, title, description, EditMode.EDIT);

      // Navigator.of(context)
      //     .pushReplacementNamed(NoteViewScreen.routeName, arguments: id);
      Navigator.of(context).popUntil(
        ModalRoute.withName('/'),
      );
    } else {
      int id = DateTime.now().millisecondsSinceEpoch;
      Provider.of<NotesProvider>(this.context, listen: false)
          .addOrUpdateNote(id, title, description, EditMode.ADD);
      // Navigator.of(context)
      //     .pushReplacementNamed(NoteViewScreen.routeName, arguments: id);
      Navigator.of(context).popUntil(
        ModalRoute.withName('/'),
      );
    }
  }
}
