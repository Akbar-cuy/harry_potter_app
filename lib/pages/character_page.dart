import 'package:flutter/material.dart';

import '../models/character.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import 'character_detail_page.dart';
import 'spell_page.dart';

class CharacterPage extends StatefulWidget {
  const CharacterPage({super.key});

  @override
  State<CharacterPage> createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  late Future<List<Character>> _future;

  @override
  void initState() {
    super.initState();
    _future = ApiService.fetchCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Harry Potter Characters'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => AuthService.logout(context),
          ),
        ],
      ),
      body: FutureBuilder<List<Character>>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text('Error: ${snap.error}'));
          }
          final list = snap.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: list.length,
            itemBuilder: (_, i) {
              final c = list[i];
              return Card(
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(
                      c.image,
                      width: 40,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.person, size: 40),
                    ),
                  ),
                  title: Text(c.fullName,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text(c.interpretedBy),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => CharacterDetailPage(character: c))),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: FilledButton.tonal(
            onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const SpellPage())),
            child: const Text('Spells'),
          ),
        ),
      ),
    );
  }
}
