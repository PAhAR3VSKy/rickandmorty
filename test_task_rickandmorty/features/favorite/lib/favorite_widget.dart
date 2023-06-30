import 'package:character_card/constructor/load_cart.dart';
import 'package:character_card/domain/character.dart';
import 'package:character_card/grid.dart';
import 'package:character_page/component/adaptive_refresh_custom_scroll_view.dart';
import 'package:character_page/component/default_error_widget.dart';
import 'package:elementary/elementary.dart';
import 'package:favorite/favorite_wm.dart';
import 'package:flutter/material.dart';

/// Виджет страницы избранного
class FavoritePageWidget extends ElementaryWidget<IFavoritePageWidgetModel> {
  /// Конструктор [FavoritePageWidget]
  const FavoritePageWidget({
    Key? key,
    WidgetModelFactory wmFactory = initFavoritePageWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IFavoritePageWidgetModel wm) {
    return SafeArea(
        child: ColoredBox(
            color: Colors.white,
            child: EntityStateNotifierBuilder<List<CharacterCard>>(
              listenableEntityState: wm.characters,
              errorBuilder: (_, e, __) => AdaptiveRefreshCustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    child: DefaultErrorWidget(
                      onTap: wm.updateData,
                      buttonText: wm.appLocalizations.reload,
                      title: wm.appLocalizations.occurredError,
                    ),
                  ),
                ],
              ),
              loadingBuilder: (_, __) => AdaptiveRefreshCustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              Expanded(child: LoadCard()),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(child: LoadCard()),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: const [
                              Expanded(child: LoadCard()),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(child: LoadCard()),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              builder: (context, characters) => AdaptiveRefreshCustomScrollView(
                shrinkWrap: true,
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.all(8),
                    sliver: SliverToBoxAdapter(
                      child: ElevatedButton(
                        onPressed: wm.updateData,
                        child: Text(wm.appLocalizations.reload),
                      ),
                    ),
                  ),
                  Grid(
                    characters: characters!,
                  )
                ],
              ),
            )));
  }
}
