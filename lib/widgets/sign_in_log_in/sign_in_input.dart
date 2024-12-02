import 'package:flutter/material.dart';

class SignInInput extends StatelessWidget {
  final TextEditingController _textController;
  final ValueChanged<String>? _onChanged;
  final String _labelText;
  final String _hintText;

  const SignInInput(this._textController, this._onChanged, this._labelText,
      this._hintText, {super.key});

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