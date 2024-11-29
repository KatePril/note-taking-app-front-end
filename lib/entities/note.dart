import 'package:note_taking_app/entities/items/item.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:convert';

class Note {
  int? _noteId;
  String _title;
  final int _userId;
  final List<Item> _items = List.empty(growable: true);

  Note(this._title, this._userId);
  Note.withId(this._noteId, this._title, this._userId);

  static Note fromJson(Map<String, dynamic> note) {
    var noteId = note["noteId"];
    var title = note["title"];
    var userId = note["user"]["userId"];
    return Note.withId(noteId, title, userId);
  }

  int get noteId => _noteId ?? -1;

  String get title => _title;

  List<Item> get items => _items;

  set title(String title) => _title = title;

  void addItem(Item item) => _items.add(item);

  pw.Document buildDocument() {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text(
              title,
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 18
              ),
            ),
          );
        }
      )
    );

    for (final Item item in items) {
      pdf.addPage(item.buildPdf());
    }

    return pdf;
  }

  Map<String, dynamic> toJson() {
    var id = _noteId != null ? '"noteId": $_noteId,' : "";
    String note = '{$id"title": "$title","user": {"userId": $_userId}}';
    return jsonDecode(note);
  }

  @override
  String toString() {
    return "$_noteId, $title, $_userId";
  }
}