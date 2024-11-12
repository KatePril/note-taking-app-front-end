import 'package:flutter/material.dart';
import 'package:note_taking_app/entities/items/text_item.dart';

class TextItemWidget extends StatefulWidget {
  final TextItem item;

  const TextItemWidget({super.key, required this.item});

  @override
  State<StatefulWidget> createState() => _TextItemWidgetState(item);
}

class _TextItemWidgetState extends State<TextItemWidget> {
  final TextItem item;
  late TextEditingController _textController;

  _TextItemWidgetState(this.item) {
    _textController = TextEditingController(text: item.text);
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
        child: TextField(
          controller: _textController,
          onChanged: (value) => item.text = _textController.text,
          maxLines: null,
        ),
      ),
    );
  }

}