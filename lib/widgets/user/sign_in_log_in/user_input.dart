import 'package:flutter/material.dart';

class UserInput extends StatelessWidget {
  final TextEditingController _textController;
  final ValueChanged<String>? _onChanged;
  final String? _labelText;
  final String _hintText;

  const UserInput({
    required TextEditingController textController,
    required ValueChanged<String> onChanged,
    required String? labelText,
    required String hintText,
    super.key,
  })  : _textController = textController,
        _onChanged = onChanged,
        _labelText = labelText,
        _hintText = hintText;


  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      onChanged: _onChanged,
      decoration: InputDecoration(
        labelText: _labelText,
        hintText: _hintText,
        hintStyle: TextStyle(color: Theme
            .of(context).colorScheme.onTertiary),
        labelStyle: TextStyle(color: Theme
            .of(context).colorScheme.primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme
              .of(context).colorScheme.primary, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme
              .of(context).colorScheme.onTertiary, width: 1.0),
        ),
        filled: true,
        fillColor: Theme
            .of(context).colorScheme.inversePrimary,
        prefixIcon: const Icon(Icons.person),
      ),
    );
  }

}