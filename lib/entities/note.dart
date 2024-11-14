import 'package:note_taking_app/entities/items/item.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Note {
  String _title;
  final List<Item> _items = List.empty(growable: true);

  Note(this._title);

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

}