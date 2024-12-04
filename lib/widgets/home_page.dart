import 'package:flutter/material.dart';
import 'package:note_taking_app/db_connection/note_api.dart';
import 'package:note_taking_app/entities/note.dart';
import 'package:note_taking_app/widgets/note/screen/note_screen.dart';
import 'package:note_taking_app/widgets/note/note_widget.dart';
import 'package:note_taking_app/widgets/user/profile_page.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  final int id;

  const MyHomePage({super.key, required this.title, required this.id});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Note> _notes = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    _notes = await NoteApi.getNotesByUser(widget.id);
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
        title: Row(
          children: [
            Text(widget.title),
            const Spacer(),
            FilledButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(
                    builder: (context) => ProfilePage(widget.id)
                  )
                );
              },
              child: const Icon(Icons.person, size: 24),
            ),
          ]
        ),
      ),
      body: ListView.builder(
        itemCount: _notes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: NoteWidget(
              note: _notes[index],
              loadNotes: _loadNotes,
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(
                  builder: (context) => NoteScreen(
                    id: _notes[index].noteId,
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