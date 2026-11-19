import 'package:flutter/material.dart';

import '../models/character.dart';

class CharacterDetailPage extends StatelessWidget {
  final Character character;
  const CharacterDetailPage({super.key, required this.character});

  Widget _row(String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 130,
              child: Text(label,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            Expanded(child: Text(value.isEmpty ? '-' : value)),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final c = character;
    return Scaffold(
      appBar: AppBar(title: Text(c.fullName)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.network(
              c.image,
              width: double.infinity,
              fit: BoxFit.fitWidth,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.person, size: 120),
            ),
            const SizedBox(height: 16),
            _row('Index', c.index.toString()),
            _row('Full Name', c.fullName),
            _row('Nickname', c.nickname),
            _row('Hogwarts House', c.hogwartsHouse),
            _row('Interpreted By', c.interpretedBy),
            _row('Children', c.children.join(', ')),
            _row('Birthdate', c.birthdate),
          ],
        ),
      ),
    );
  }
}
