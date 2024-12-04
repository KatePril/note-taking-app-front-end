import 'package:note_taking_app/db_connection/item_api.dart';
import 'package:note_taking_app/entities/items/item.dart';
import 'package:note_taking_app/entities/jsonable.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:convert';

class Note implements Jsonable {
  int? _noteId;
  String title;
  final int _userId;

  Note(this.title, this._userId);
  Note.withId(this._noteId, this.title, this._userId);

  int get noteId => _noteId ?? -1;

  static Note fromJson(Map<String, dynamic> note) {
    var noteId = note["noteId"];
    var title = note["title"];
    var userId = note["user"]["userId"];
    return Note.withId(noteId, title, userId);
  }

  Future<pw.Document> buildDocument() async {
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

    List<Item> items = await ItemApi.getItemsByNote(noteId);
    for (final Item item in items) {
      pdf.addPage(item.buildPdf());
    }

    return pdf;
  }

  @override
  Map<String, dynamic> toJson() {
    var id = _noteId != null ? '"noteId": $_noteId,' : "";
    String note = '{$id"title": "$title","user": {"userId": $_userId}}';
    return jsonDecode(note);
  }
}