import 'package:flutter/material.dart';
import 'package:note_taking_app/db_connection/note_api.dart';
import 'package:note_taking_app/entities/note.dart';
import 'package:note_taking_app/widgets/delete_button.dart';

class NoteWidget extends StatelessWidget {
  final Note note;
  final Function loadNotes;

  const NoteWidget({required this.note, required this.loadNotes, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme
          .of(context)
          .colorScheme
          .primary,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox(
              height: 50,
              child: Center(
                child: Text(
                  note.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const Spacer(),
            DeleteButton(
              onPressed: () async {
                await NoteApi.deleteNoteById(note.noteId);
                loadNotes();
              },
              width: null,
            ),
          ],
        ),
      ),
    );
  }
}