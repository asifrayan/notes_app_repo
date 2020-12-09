import 'package:intl/intl.dart';

class Note {
  int _id;
  String _title;
  String _description;

  Note(this._id, this._title, [this._description = '']);

  int get id => _id;

  String get title => _title;

  String get description => _description;

  String get date {
    final date = DateTime.fromMillisecondsSinceEpoch(id);
    return DateFormat('EEE h:mm a, MMM dd, yyyy').format(date);
  }

  String get onlyDate {
    final date = DateTime.fromMillisecondsSinceEpoch(id);
    return DateFormat('MMM dd, yyyy').format(date);
  }
}
