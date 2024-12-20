import 'package:flutter/material.dart';
import 'package:note_taking_app/db_connection/item_api.dart';
import 'package:note_taking_app/entities/items/text_item.dart';
import 'package:note_taking_app/widgets/delete_button.dart';

class TextItemWidget extends StatefulWidget {
  final TextItem item;
  final Function loadItems;

  const TextItemWidget({super.key, required this.item, required this.loadItems});

  @override
  State<StatefulWidget> createState() => _TextItemWidgetState();
}

class _TextItemWidgetState extends State<TextItemWidget> {
  late TextItem _item;
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _item = widget.item;
    _textController = TextEditingController(text: _item.text);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme
          .of(context)
          .colorScheme
          .inversePrimary,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              onChanged: (value) => _item.text = _textController.text,
              maxLines: null,
            ),
            const SizedBox(height: 10),
            DeleteButton(
              onPressed: () async {
                await ItemApi.deleteItemById(widget.item.itemId);
                widget.loadItems();
              },
              width: double.infinity,
            ),
          ],
        )
      ),
    );
  }

}