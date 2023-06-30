import 'package:character_card/domain/character.dart';
import 'package:elementary/elementary.dart';
import 'package:favorite/di/favorite_scope.dart';
import 'package:favorite/favorite_model.dart';
import 'package:favorite/favorite_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:test_task_rickandmorty/generated/l10n.dart';

/// Интерфейс WM страницы избранного
abstract class IFavoritePageWidgetModel extends IWidgetModel {
  /// Локализация
  AppLocalizations get appLocalizations;

  /// Список персонажей
  ListenableState<EntityState<List<CharacterCard>>> get characters;

  /// Обновление данных
  void updateData();
}

/// Фабрика WM Страницы Избранного
FavoritePageWidgetModel initFavoritePageWidgetModelFactory(
  BuildContext context,
) {
  final scope = context.read<IFavoritePageScope>();
  final model = scope.model;
  final appLocalizations = AppLocalizations.of(context);
  return FavoritePageWidgetModel(
    model,
    appLocalizations: appLocalizations,
  );
}

/// WM страницы Избранного
class FavoritePageWidgetModel
    extends WidgetModel<FavoritePageWidget, FavoritePageModel>
    implements IFavoritePageWidgetModel {
  final EntityStateNotifier<List<CharacterCard>> _characters =
      EntityStateNotifier<List<CharacterCard>>();

  @override
  ListenableState<EntityState<List<CharacterCard>>> get characters =>
      _characters;

  @override
  final AppLocalizations appLocalizations;

  /// Конструктор [FavoritePageWidgetModel]
  FavoritePageWidgetModel(
    FavoritePageModel model, {
    required this.appLocalizations,
  }) : super(model);

  @override
  Future<void> initWidgetModel() async {
    _initLoad();
    super.initWidgetModel();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Future<void> updateData() async {
    await _loadFavorite();
  }

  Future<void> _loadFavorite() async {
    var listId = await model.loadId();
    final characterList = <CharacterCard>[];
    for (final id in listId) {
      characterList.add(await model.getCharactersId(id));
    }
    if (characterList.isNotEmpty) {
      _characters.content(characterList);
    } else {
      _characters.error();
    }
  }

  Future<void> _initLoad() async {
    try {
      _characters.loading();
      _loadFavorite();
    } on FormatException catch (e) {
      _characters.error(e);
    }
  }
}
