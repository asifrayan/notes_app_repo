import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';
import '../provider/notes_provider.dart';

class DeletePopUp extends StatelessWidget {
  final Note selectedNote;

  DeletePopUp({this.selectedNote});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      title: const Text('Delete?'),
      content: const Text('Do you want to delete the note?'),
      actions: [
        FlatButton(
          child: const Text('Yes'),
          onPressed: () {
            Provider.of<NotesProvider>(context, listen: false)
                .deleteNote(selectedNote.id);
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
        ),
        FlatButton(
          child: const Text('No'),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
