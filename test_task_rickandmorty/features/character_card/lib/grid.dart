import 'package:character_card/character_card_widget.dart';
import 'package:character_card/character_card_wm.dart';
import 'package:character_card/domain/character.dart';
import 'package:flutter/material.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

/// сетка персонажей
class Grid extends StatelessWidget {
  /// персонажи
  final List<CharacterCard> characters;

  ///отступ сверху
  final double fromTop;

  /// Заголовок
  final Widget? title;

  /// конструктор [Grid]
  const Grid({
    required this.characters,
    this.fromTop = 0,
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SuperSliverList(
      delegate: SliverChildListDelegate([
        SizedBox(
          height: fromTop,
        ),
        if (title != null) title!,
        for (var i = 0, len = characters.length; i < len; i += 2)
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 8),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: CharacterCardWidget(
                      wmFactory: (context) =>
                          initCharacterCardWidgetModelFactory(
                        context,
                        info: characters[i],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: i < len - 1
                        ? CharacterCardWidget(
                            key: ObjectKey(characters[i]),
                            wmFactory: (context) =>
                                initCharacterCardWidgetModelFactory(
                              context,
                              info: characters[i + 1],
                            ),
                          )
                        : const SizedBox(),
                  ),
                ],
              ),
            ),
          ),
      ]),
    );
  }
}
