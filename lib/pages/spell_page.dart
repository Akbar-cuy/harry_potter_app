import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/spell.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import '../widgets/app_snackbar.dart';
import 'character_page.dart';
import 'favorite_spell_page.dart';

class SpellPage extends StatefulWidget {
  const SpellPage({super.key});

  @override
  State<SpellPage> createState() => _SpellPageState();
}

class _SpellPageState extends State<SpellPage> {
  late Future<List<Spell>> _future;
  final Box _box = Hive.box('favorites');

  @override
  void initState() {
    super.initState();
    _future = ApiService.fetchSpells();
  }

  void _toggle(Spell s) {
    if (_box.containsKey(s.index)) {
      _box.delete(s.index);
      showAppSnackbar(
          title: 'Remove!',
          message: '${s.spell} removed from fav list!',
          success: false);
    } else {
      _box.put(s.index, s.toMap());
      showAppSnackbar(
          title: 'Add!',
          message: '${s.spell} successfully added to fav list!',
          success: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Harry Potter Spells Gallery'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => AuthService.logout(context),
          ),
        ],
      ),
      body: FutureBuilder<List<Spell>>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text('Error: ${snap.error}'));
          }
          final list = snap.data!;
          return ValueListenableBuilder(
            valueListenable: _box.listenable(),
            builder: (context, Box box, _) => ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: list.length,
              itemBuilder: (_, i) {
                final s = list[i];
                final fav = box.containsKey(s.index);
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.book),
                    title: Text(s.spell,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text(s.use),
                    trailing: IconButton(
                      icon: Icon(Icons.favorite,
                          color: fav ? Colors.red : Colors.grey[800]),
                      onPressed: () => _toggle(s),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const FavoriteSpellPage())),
        child: const Icon(Icons.favorite, color: Colors.red),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: FilledButton.tonal(
            onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const CharacterPage())),
            child: const Text('Characters'),
          ),
        ),
      ),
    );
  }
}
