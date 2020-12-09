import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './note_edit_screen.dart';
import '../provider/notes_provider.dart';
import '../utility/constants.dart';
import '../widgets/notes_grid.dart';

class NotesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<NotesProvider>(context, listen: false).getNotes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: const Center(
              child: const CircularProgressIndicator(),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: const Text(
                'Notes',
                style: NOTESHEADERSTYLE,
              ),
            ),
            body: Consumer<NotesProvider>(
              builder: (context, noteProvider, ch) {
                if (noteProvider.items.length <= 0) {
                  return Center(
                    child: const Text(
                      'No notes yet!',
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                } else {
                  return NotesGrid();
                }
              },
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(NoteEditScreen.routeName);
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        }
      },
    );
  }
}
