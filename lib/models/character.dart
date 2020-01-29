enum Status { ALIVE, DEAD, UNKNOWN }

class Location {
  final String name;
  final String url;

  Location({
    this.name,
    this.url
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'] as String,
      url: json['url'] as String
      );
  }
}

class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final Location origin;
  final Location location;
  final String created;
  final String image;

  Character({
    this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.origin,
    this.location,
    this.created,
    this.image,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'status': status,
        'species': species,
        'type': type,
        'gender': gender,
        'origin': origin,
        'location': location,
        'created': created,
        'image': image,
      };

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'] as int,
      name: json['name'] as String,
      status: json['status'] as String,
      species: json['species'] as String,
      type: json['type'] as String,
      gender: json['gender'] as String,
      origin: json['origin'] != null ? new Location.fromJson(json['origin']) : null,
      location: json['location'] != null ? Location.fromJson(json['location']) : null,
      created: json['created'] as String,
      image: json['image'] as String,
    );
  }
}

class CharacterList {
  List<Character> characters;

  CharacterList({this.characters});
}
