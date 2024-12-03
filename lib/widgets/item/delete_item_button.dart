import 'package:flutter/material.dart';
import 'package:note_taking_app/db_connection/item_api.dart';

class DeleteItemButton extends StatefulWidget {
  final int itemId;
  final Function loadItems;

  const DeleteItemButton({
    required this.itemId,
    required this.loadItems,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _DeleteItemButtonState();
}

class _DeleteItemButtonState extends State<DeleteItemButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: () async {
          await ItemApi.deleteItemById(widget.itemId);
          widget.loadItems();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.error),
        ),
        child: const Icon(Icons.delete, size: 24),
      ),
    );
  }

}