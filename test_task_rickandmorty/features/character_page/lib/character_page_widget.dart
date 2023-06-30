import 'package:character_card/constructor/load_cart.dart';
import 'package:character_card/domain/character.dart';
import 'package:character_card/grid.dart';
import 'package:character_page/character_page_wm.dart';
import 'package:character_page/component/adaptive_refresh_custom_scroll_view.dart';
import 'package:character_page/component/default_error_widget.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

/// Виджет страницы с персонажами
class CharacterPageWidget extends ElementaryWidget<ICharacterPageWidgetModel> {
  /// Конструктор страницы с персонажами
  const CharacterPageWidget({
    Key? key,
    WidgetModelFactory wmFactory = initCharacterPageWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(ICharacterPageWidgetModel wm) {
    return SafeArea(
      child: ColoredBox(
        color: Colors.white,
        child: EntityStateNotifierBuilder<List<CharacterCard>>(
          listenableEntityState: wm.characterCard,
          errorBuilder: (_, e, __) => AdaptiveRefreshCustomScrollView(
            slivers: [
              SliverFillRemaining(
                child: DefaultErrorWidget(
                  onTap: wm.clearAndReload,
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
          builder: (ctx, character) => AdaptiveRefreshCustomScrollView(
            controller: wm.scroll,
            shrinkWrap: true,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(8),
                sliver: SliverToBoxAdapter(
                  child: ElevatedButton(
                    onPressed: wm.refresh,
                    child: Text(wm.appLocalizations.reload),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(8),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    children: [
                      wm.gender.value!.data! == Gender.none
                          ? Text(wm.appLocalizations.choiceGender)
                          : Text(
                              '${wm.appLocalizations.gender}: ${wm.gender.value!.data!.name}'),
                      const Spacer(),
                      PopupMenuButton<Gender>(
                        initialValue: Gender.none,
                        onSelected: (Gender item) {
                          wm.choiceGender(item);
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<Gender>>[
                          PopupMenuItem<Gender>(
                            value: Gender.female,
                            child: Text(Gender.female.name),
                          ),
                          PopupMenuItem<Gender>(
                            value: Gender.male,
                            child: Text(Gender.male.name),
                          ),
                          PopupMenuItem<Gender>(
                            value: Gender.unknown,
                            child: Text(Gender.unknown.name),
                          ),
                          PopupMenuItem<Gender>(
                            value: Gender.none,
                            child: Text(Gender.none.name),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(8),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    children: [
                      wm.status.value!.data! == Status.none
                          ? Text(wm.appLocalizations.choiceStatus)
                          : Text(
                              '${wm.appLocalizations.status}: ${wm.status.value!.data!.name}'),
                      const Spacer(),
                      PopupMenuButton<Status>(
                        initialValue: Status.none,
                        onSelected: (Status item) {
                          wm.choiceStatus(item);
                        },
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<Status>>[
                          PopupMenuItem<Status>(
                            value: Status.alive,
                            child: Text(Status.alive.name),
                          ),
                          PopupMenuItem<Status>(
                            value: Status.dead,
                            child: Text(Status.dead.name),
                          ),
                          PopupMenuItem<Status>(
                            value: Status.unknown,
                            child: Text(Status.unknown.name),
                          ),
                          PopupMenuItem<Status>(
                            value: Status.none,
                            child: Text(Status.none.name),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(8),
                sliver: SliverToBoxAdapter(
                  child: TextField(
                    controller: wm.nameController,
                    onEditingComplete: wm.refresh,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: wm.appLocalizations.writeName,
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(8),
                sliver: SliverToBoxAdapter(
                  child: TextField(
                    controller: wm.speciesController,
                    onEditingComplete: wm.refresh,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: wm.appLocalizations.writeSpecies,
                    ),
                  ),
                ),
              ),
              Grid(
                characters: character!,
              ),
              SliverPadding(
                padding: const EdgeInsets.all(32),
                sliver: SliverToBoxAdapter(
                  child: EntityStateNotifierBuilder<bool>(
                    listenableEntityState: wm.loadIndicator,
                    builder: (_, state) => state!
                        ? CircularProgressIndicator.adaptive()
                        : SizedBox.shrink(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
