enum Status { ALIVE, DEAD, UNKNOWN }

class Character {
  final int id;
  final String name;
  final String status;
  final String image;

  Character({this.id, this.name, this.status, this.image});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'status': status,
        'image': image,
      };

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'] as int,
      name: json['name'] as String,
      status: json['status'] as String,
      image: json['image'] as String,
    );
  }
}

class CharacterList {
  List<Character> characters;

  CharacterList({this.characters});
}
