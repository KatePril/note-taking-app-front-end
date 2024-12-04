import 'package:flutter/material.dart';
import 'package:note_taking_app/db_connection/note_api.dart';
import 'package:note_taking_app/entities/note.dart';
import 'package:note_taking_app/widgets/delete_button.dart';

class NoteWidget extends StatelessWidget {
  final Note _note;
  final Function _loadNotes;

  const NoteWidget({required Note note, required Function loadNotes, super.key}) : _loadNotes = loadNotes, _note = note;

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
                  _note.title,
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
                await NoteApi.deleteNoteById(_note.noteId);
                _loadNotes();
              },
              width: null,
            ),
          ],
        ),
      ),
    );
  }
}