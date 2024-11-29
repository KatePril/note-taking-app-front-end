import 'package:note_taking_app/entities/note.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'constants.dart' as constants;

class NoteApi {
  NoteApi._internal();

  static final NoteApi _instance = NoteApi._internal();

  factory NoteApi() {
    return _instance;
  }

  static final _uri = "${constants.uri}notes";

  static void createNote(Note note) async {
    http.Response response = await http.post(
      Uri.parse(_uri),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(note.toJson()),
    );
  }

  static Future<Note> updateNote(Note note) async {
    print(note);
    print(jsonEncode(note.toJson()));
    http.Response response = await http.put(
      Uri.parse(_uri),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(note.toJson()),
    );
    Note updatedNote = Note.fromJson(jsonDecode(response.body));
    return updatedNote;
  }
  
  static Future<List<Note>> getNotesByUser(int id) async {
    http.Response response = await http.get(
      Uri.parse("$_uri/$id"),
    );
    List<Note> notes = List.empty(growable: true);
    for (final note in jsonDecode(response.body)) {
      notes.add(Note.fromJson(note));
    }
    return notes;
  }
}