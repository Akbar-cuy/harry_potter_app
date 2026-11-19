class Spell {
  final int index;
  final String spell;
  final String use;

  Spell({required this.index, required this.spell, required this.use});

  factory Spell.fromJson(Map json) => Spell(
        index: json['index'] ?? 0,
        spell: (json['spell'] ?? '').toString(),
        use: (json['use'] ?? '').toString(),
      );

  Map<String, dynamic> toMap() =>
      {'index': index, 'spell': spell, 'use': use};
}
