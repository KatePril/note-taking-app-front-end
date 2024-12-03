import 'package:flutter/material.dart';
import 'package:note_taking_app/db_connection/note_api.dart';
import 'package:note_taking_app/entities/note.dart';
import 'package:note_taking_app/widgets/note/screen/note_screen.dart';
import 'package:note_taking_app/widgets/note/note_widget.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  final int id;

  const MyHomePage({super.key, required this.title, required this.id});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Note> notes = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    notes = await NoteApi.getNotesByUser(widget.id);
    setState(() {});
  }

  Future<void> _addNote() async {
    await NoteApi.createNote(Note("New note", widget.id));
    _loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: NoteWidget(notes[index].title),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(
                  builder: (context) => NoteScreen(
                    id: notes[index].noteId,
                    homeState: () => _loadNotes(),
                  )
                )
              );
            },
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        tooltip: 'Add note',
        child: const Icon(Icons.add),
      ),
    );
  }
}