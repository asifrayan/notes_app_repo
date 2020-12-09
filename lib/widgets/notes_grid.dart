import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './note_item.dart';
import '../provider/notes_provider.dart';
import '../utility/colors.dart';

class NotesGrid extends StatelessWidget {
  int indexColor = -1;

  int getIndexColor() {
    if (indexColor >= 6) {
      indexColor = 0;
    } else {
      indexColor++;
    }
    return indexColor;
  }

  @override
  Widget build(BuildContext context) {
    final notesList = Provider.of<NotesProvider>(context, listen: false).items;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: GridView.builder(
          itemCount: notesList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2 / 2),
          itemBuilder: (context, index) {
            return NoteItem(
              ValueKey(notesList[index].id),
              notesList[index],
              color[getIndexColor()],
            );
          }),
    );
  }
}
