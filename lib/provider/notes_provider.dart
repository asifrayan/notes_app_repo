import 'package:flutter/material.dart';

import '../helper/db_helper.dart';
import '../models/note.dart';
import '../utility/constants.dart';

class NotesProvider with ChangeNotifier {
  List<Note> _items = [];

  List<Note> get items {
    return [..._items];
  }

  Future<List<Note>> getNotes() async {
    final notesList = await DatabaseHelper.getNotesFromDB();

    _items = notesList
        .map(
          (item) => Note(
            item['id'],
            item['title'],
            item['description'],
          ),
        )
        .toList();

    notifyListeners();
  }

  Note getNoteById(int id) {
    return _items.firstWhere((item) => item.id == id);
  }

  Future<void> addOrUpdateNote(
      int id, String title, String description, EditMode editMode) async {
    final note = Note(id, title, description);

    if (EditMode.ADD == editMode) {
      _items.insert(0, note);
    } else {
      _items[_items.indexWhere((note) => note.id == id)] = note;
    }

    notifyListeners();

    DatabaseHelper.insert(
      {
        'id': note.id,
        'title': note.title,
        'description': note.description,
      },
    );
  }

  Future deleteNote(int id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
    return DatabaseHelper.delete(id);
  }
}
