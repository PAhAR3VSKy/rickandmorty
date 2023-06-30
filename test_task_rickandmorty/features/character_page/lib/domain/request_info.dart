import 'package:character_card/domain/character.dart';
import 'package:character_page/domain/info.dart';

/// Полная информация запроса
class RequestInfo {
  /// Список персонажей
  final List<CharacterCard> characters;

  /// Информация запроса
  final Info info;

  /// Конструктор [RequestInfo]
  RequestInfo({
    required this.characters,
    required this.info,
  });
}
