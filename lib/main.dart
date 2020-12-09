import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './provider/notes_provider.dart';
import './screens/note_edit_screen.dart';
import './screens/note_view_screen.dart';
import './screens/notes_list_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NotesProvider>(
      create: (_) => NotesProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notes',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
          accentColor: Colors.black,
          canvasColor: Colors.grey[900],
          fontFamily: 'OpenSans',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (_) => NotesListScreen(),
          NoteViewScreen.routeName: (_) => NoteViewScreen(),
          NoteEditScreen.routeName: (_) => NoteEditScreen(),
        },
      ),
    );
  }
}
