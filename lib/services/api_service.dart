import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/character.dart';
import '../models/spell.dart';

class ApiService {
  static const _base = 'https://potterapi-fedeperin.vercel.app/en';

  static Future<List<Character>> fetchCharacters() async {
    final res = await http.get(Uri.parse('$_base/characters'));
    if (res.statusCode != 200) {
      throw Exception('Gagal memuat karakter (${res.statusCode})');
    }
    final List data = jsonDecode(res.body);
    return data.map((e) => Character.fromJson(e)).toList();
  }

  static Future<List<Spell>> fetchSpells() async {
    final res = await http.get(Uri.parse('$_base/spells'));
    if (res.statusCode != 200) {
      throw Exception('Gagal memuat spell (${res.statusCode})');
    }
    final List data = jsonDecode(res.body);
    return data.map((e) => Spell.fromJson(e)).toList();
  }
}
