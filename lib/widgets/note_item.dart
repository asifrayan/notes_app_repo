import 'package:flutter/material.dart';

import './delete_popup.dart';
import '../models/note.dart';
import '../screens/note_view_screen.dart';
import '../utility/constants.dart';

class NoteItem extends StatelessWidget {
  final Key key;
  final Color color;
  final Note note;

  NoteItem(this.key, this.note, this.color);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(NoteViewScreen.routeName, arguments: note.id);
      },
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) {
            return DeletePopUp(selectedNote: note);
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              note.title,
              style: NOTECARDTITLESTYLE,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
            Container(
              width: double.infinity,
              child: Text(
                note.onlyDate,
                style: TextStyle(color: Colors.black87),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
