import 'package:flutter/material.dart';

class DeleteButton extends StatefulWidget {
  final Function onPressed;
  final double? width;

  const DeleteButton({required this.onPressed, required this.width, super.key});

  @override
  State<StatefulWidget> createState() => _DeleteButtonState();
}

class _DeleteButtonState extends State<DeleteButton> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: FilledButton(
        onPressed: () => widget.onPressed(),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.error),
        ),
        child: const Icon(Icons.delete, size: 24),
      ),
    );
  }
}