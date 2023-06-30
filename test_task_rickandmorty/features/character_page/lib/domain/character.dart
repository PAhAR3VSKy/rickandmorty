import 'package:character_card/domain/character.dart';

/// Сущность списка персонажей
class CharactersList {
  /// список персонажей
  final List<CharacterCard> characters;

  /// Конструктор [CharactersList]
  CharactersList({
    required this.characters,
  });
}
