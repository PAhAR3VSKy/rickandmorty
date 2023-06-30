import 'package:character_card/character_card_model.dart';
import 'package:character_card/character_card_widget.dart';
import 'package:character_card/constructor/custom_bottom_sheet.dart';
import 'package:character_card/domain/character.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_task_rickandmorty/app/di/app_scope.dart';
import 'package:test_task_rickandmorty/generated/l10n.dart';

/// Интерфейс WM карточки персонажа
abstract class ICharacterCardWidhetModel extends IWidgetModel {
  /// Локализация
  AppLocalizations get appLocalizations;

  /// Инфо персонажа
  CharacterCard get info;

  /// Флаг избранного
  ListenableState<EntityState<bool>> get inFavorite;

  /// Добавление в избранное
  Future<void> onTracked(int id);

  /// Вывод BS с информацией
  Future<void> showInfo();
}

/// Фабрика WM карточки персонажа
CharacterCardWidgetModel initCharacterCardWidgetModelFactory(
  BuildContext context, {
  required CharacterCard info,
}) {
  final appDependencies = context.read<IAppScope>();
  final model = appDependencies.characterCardModel;
  final appLocalizations = AppLocalizations.of(context);
  return CharacterCardWidgetModel(
    model,
    appLocalizations: appLocalizations,
    info: info,
  );
}

/// WM карточки персонажа
class CharacterCardWidgetModel
    extends WidgetModel<CharacterCardWidget, CharacterCardModel>
    implements ICharacterCardWidhetModel {
  final EntityStateNotifier<bool> _inFavorite = EntityStateNotifier<bool>()
    ..content(false);

  late final CharacterCard _info;

  @override
  final AppLocalizations appLocalizations;

  @override
  CharacterCard get info => _info;

  @override
  ListenableState<EntityState<bool>> get inFavorite => _inFavorite;

  /// Конструктор [CharacterCardWidgetModel]
  CharacterCardWidgetModel(
    CharacterCardModel model, {
    required this.appLocalizations,
    required CharacterCard info,
  })  : _info = info,
        super(model);

  @override
  Future<void> initWidgetModel() async {
    if (await model.isTracked(info.id)) {
      _inFavorite.content(true);
    } else {
      _inFavorite.content(false);
    }
    super.initWidgetModel();
  }

  @override
  Future<void> onTracked(int id) async {
    await model.onTracked(id);
    if (await model.isTracked(id)) {
      _inFavorite.content(true);
    } else {
      _inFavorite.content(false);
    }
  }

  @override
  Future<void> showInfo() async {
    await showModalBottomSheet(
      context: context,
      builder: (context) => BottomSheetCustom(
        title: info.name,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(info.image),
              ),
              Text('${appLocalizations.name}: ${info.name}'),
              Text('${appLocalizations.species}: ${info.species}'),
              Text('${appLocalizations.gender}: ${info.gender}'),
              Text('${appLocalizations.status}: ${info.status}'),
              Text('${appLocalizations.type}: ${info.type}'),
              Text('${appLocalizations.origin}: ${info.origin.name}'),
              Text('${appLocalizations.location}: ${info.location.name}'),
              Text(
                  '${appLocalizations.created}: ${info.created.day}.${info.created.month}.${info.created.year}'),
            ],
          ),
        ),
      ),
    );
  }
}
