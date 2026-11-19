class Character {
  final int index;
  final String fullName;
  final String nickname;
  final String hogwartsHouse;
  final String interpretedBy;
  final List<String> children;
  final String image;
  final String birthdate;

  Character({
    required this.index,
    required this.fullName,
    required this.nickname,
    required this.hogwartsHouse,
    required this.interpretedBy,
    required this.children,
    required this.image,
    required this.birthdate,
  });

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        index: json['index'] ?? 0,
        fullName: (json['fullName'] ?? '').toString(),
        nickname: (json['nickname'] ?? '').toString(),
        hogwartsHouse: (json['hogwartsHouse'] ?? '').toString(),
        interpretedBy: (json['interpretedBy'] ?? '').toString(),
        children: (json['children'] as List? ?? [])
            .map((e) => e.toString())
            .toList(),
        image: (json['image'] ?? '').toString(),
        birthdate: (json['birthdate'] ?? '').toString(),
      );
}
