import 'package:character_card/domain/character.dart';
import 'package:flutter/material.dart';
import 'package:test_task_rickandmorty/generated/l10n.dart';

/// Информация о персонаже
class CharacterInfo extends StatelessWidget {
  /// Информация карточки
  final CharacterCard info;

  /// Локализация
  final AppLocalizations appLocalizations;

  /// Конструктор [CharacterInfo]
  const CharacterInfo({
    required this.appLocalizations,
    required this.info,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            info.name,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
