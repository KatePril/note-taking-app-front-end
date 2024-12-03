import 'package:flutter/material.dart';
import 'package:note_taking_app/db_connection/item_api.dart';
import 'package:note_taking_app/entities/items/header_item.dart';

class HeaderItemWidget extends StatefulWidget {
  final HeaderItem item;

  const HeaderItemWidget({super.key, required this.item});

  @override
  State<StatefulWidget> createState() => _HeaderItemWidgetState();

}

class _HeaderItemWidgetState extends State<HeaderItemWidget> {
  late HeaderItem item;
  late TextEditingController _headerController;

  @override
  void initState() {
    super.initState();
    item = widget.item;
    _headerController = TextEditingController(text: item.text);
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
              onChanged: (value) => item.text = _headerController.text,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity, // Makes the button fill the available width
              child: FilledButton(
                onPressed: () => ItemApi.deleteItemById(item.itemId ?? -1),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.error),
                ),
                child: const Icon(Icons.delete, size: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }

}