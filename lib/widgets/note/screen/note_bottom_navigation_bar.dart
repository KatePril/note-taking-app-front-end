import 'package:flutter/material.dart';

class NoteBottomNavigationBar extends StatelessWidget {
  final Map<int, Function()> _functions;

  const NoteBottomNavigationBar({super.key, required Map<int, dynamic Function()> functions}) : _functions = functions;

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
      onTap: (index) => _functions[index]!(),
    );
  }
}
