import 'package:character_card/character_card_wm.dart';
import 'package:character_card/constructor/character_info.dart';
import 'package:character_card/constructor/image_block.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

/// Виджет карточки персонажа
class CharacterCardWidget extends ElementaryWidget<ICharacterCardWidhetModel> {
  /// Конструктор [CharacterCardWidget]
  const CharacterCardWidget({
    required WidgetModelFactory wmFactory,
    Key? key,
  }) : super(wmFactory, key: key);

  @override
  Widget build(ICharacterCardWidhetModel wm) {
    return GestureDetector(
      onTap: wm.showInfo,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(14)),
          color: Colors.grey,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ImageBlock(
              inFavorite: wm.inFavorite,
              url: wm.info.image,
              onFavorite: () => wm.onTracked(wm.info.id),
            ),
            const SizedBox(
              height: 10,
            ),
            CharacterInfo(
              info: wm.info,
              appLocalizations: wm.appLocalizations,
            ),
          ],
        ),
      ),
    );
  }
}
