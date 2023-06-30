/// Сущность персонажа
class CharacterCard extends ICharacter {
  final int _id;
  final String _name;
  final String _status;
  final String _species;
  final String _type;
  final String _gender;
  final CharacterLocation _origin;
  final CharacterLocation _location;
  final String _image;
  final List<String> _episode;
  final String _url;
  final DateTime _created;

  @override
  int get id => _id;

  @override
  String get name => _name;

  @override
  String get status => _status;

  @override
  String get species => _species;

  @override
  String get type => _type;

  @override
  String get gender => _gender;

  @override
  CharacterLocation get origin => _origin;

  @override
  CharacterLocation get location => _location;

  @override
  String get image => _image;

  @override
  List<String> get episode => _episode;

  @override
  String get url => _url;

  @override
  DateTime get created => _created;

  /// Конструктор [CharacterCard]
  CharacterCard({
    required int id,
    required String name,
    required String status,
    required String species,
    required String type,
    required String gender,
    required CharacterLocation origin,
    required CharacterLocation location,
    required String image,
    required List<String> episode,
    required String url,
    required DateTime created,
  })  : _id = id,
        _name = name,
        _status = status,
        _species = species,
        _type = type,
        _gender = gender,
        _origin = origin,
        _location = location,
        _image = image,
        _episode = episode,
        _url = url,
        _created = created;
}

/// Интерфейс сущности персонажа
abstract class ICharacter {
  /// The id of the character.
  int get id;

  /// The name of the character.
  String get name;

  /// The status of the character ('Alive', 'Dead' or 'unknown').
  String get status;

  /// The species of the character.
  String get species;

  /// The type or subspecies of the character.
  String get type;

  /// The gender of the character ('Female', 'Male', 'Genderless' or 'unknown').
  String get gender;

  /// Name and link to the character's origin location.
  CharacterLocation get origin;

  /// Name and link to the character's last known location endpoint.
  CharacterLocation get location;

  /// Link to the character's image. All images are 300x300px and most are medium shots or portraits since they are intended to be used as avatars.
  String get image;

  /// List of episodes in which this character appeared.
  List<String> get episode;

  /// Link to the character's own URL endpoint.
  String get url;

  /// Time at which the character was created in the database.
  DateTime get created;
}

/// Location Character
class CharacterLocation {
  /// name
  final String name;

  /// url
  final String url;

  /// Конструктор [CharacterLocation]
  CharacterLocation({
    required this.name,
    required this.url,
  });
}
