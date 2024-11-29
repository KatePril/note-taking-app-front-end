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
    for (final Note note in notes) {
      print("${note.noteId} : ${note.title}");
    }
  }

  void _addNote() => setState(() {
      notes.add(Note("New note", widget.id));
      NoteApi.createNote(Note("New note", widget.id));
    });

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
                     note: notes[index],
                    homeState: setState,
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