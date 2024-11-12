import 'package:flutter/material.dart';

class NoteBottomNavigationBar extends StatelessWidget {
  const NoteBottomNavigationBar({super.key, required this.functions});
  final Map<int, Function()> functions;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.h_mobiledata),
          label: 'Header',
          backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.text_fields),
          label: 'Text',
          backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.image),
          label: 'Image',
          backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.draw),
          label: 'Draw',
          backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ],
      onTap: (index) {
        functions[index]!();
      },
    );
  }
}
