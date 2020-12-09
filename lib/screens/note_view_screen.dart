import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './note_edit_screen.dart';
import '../models/note.dart';
import '../provider/notes_provider.dart';
import '../widgets/delete_popup.dart';

class NoteViewScreen extends StatelessWidget {
  static const routeName = '/note-view';

  NoteViewScreen() {
    print('NoteViewScreen CONSTRUCTOR');
  }

  @override
  Widget build(BuildContext context) {
    print('Build() of NoteViewScreen');
    final noteId = ModalRoute.of(context).settings.arguments;
    final noteProvider = Provider.of<NotesProvider>(context, listen: false);
    final note = noteProvider.getNoteById(noteId);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(NoteEditScreen.routeName, arguments: noteId);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _showDialog(context, note);
              // noteProvider.deleteNote(noteId);
              // Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style: TextStyle(fontSize: 37, height: 1.1),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                note.date,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                note.description,
                style: TextStyle(
                  color: Colors.grey[200],
                  fontSize: 17,
                  height: 1.8,
                  wordSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog(BuildContext ctx, Note selectedNote) {
    showDialog(
        context: ctx,
        builder: (context) {
          return DeletePopUp(selectedNote: selectedNote);
        });
  }
}
