import 'package:flutter/material.dart';
import 'package:note_taking_app/db_connection/item_api.dart';
import 'package:note_taking_app/entities/items/header_item.dart';
import 'package:note_taking_app/widgets/delete_button.dart';

class HeaderItemWidget extends StatefulWidget {
  final HeaderItem item;
  final Function loadItems;

  const HeaderItemWidget({super.key, required this.item, required this.loadItems});

  @override
  State<StatefulWidget> createState() => _HeaderItemWidgetState();

}

class _HeaderItemWidgetState extends State<HeaderItemWidget> {
  late HeaderItem _item;
  late TextEditingController _headerController;

  @override
  void initState() {
    super.initState();
    _item = widget.item;
    _headerController = TextEditingController(text: _item.text);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme
          .of(context)
          .colorScheme
          .primary,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: _headerController,
              onChanged: (value) => _item.text = _headerController.text,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
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
        ),
      ),
    );
  }

}