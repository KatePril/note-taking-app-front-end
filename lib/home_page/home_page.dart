import 'package:flutter/material.dart';
import 'package:note_taking_app/entities/note.dart';
import 'package:note_taking_app/widgets/note/screen/note_screen.dart';
import 'package:note_taking_app/widgets/note/note_widget.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Note> notes = List.empty(growable: true);

  void _addNote() {
    setState(() {
      notes.add(Note("New note"));
    });
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
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}