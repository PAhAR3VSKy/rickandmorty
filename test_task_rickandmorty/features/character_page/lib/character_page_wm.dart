import 'dart:async';

import 'package:character_card/domain/character.dart';
import 'package:character_page/character_page_model.dart';
import 'package:character_page/character_page_widget.dart';
import 'package:character_page/di/character_page_scope.dart';
import 'package:character_page/domain/info.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_task_rickandmorty/generated/l10n.dart';

/// Фильтр по статусу
enum Status {
  /// Живые
  alive,

  /// Мертвые
  dead,

  /// Неизвестнл
  unknown,

  ///
  none,
}

/// Фильтр по гендеру
enum Gender {
  /// Женщина
  female,

  /// Мужчина
  male,

  /// Неизвестно
  unknown,

  ///
  none,
}

/// Интерфейс страницы с персонажами
abstract class ICharacterPageWidgetModel extends IWidgetModel {
  /// глобальная локализация
  AppLocalizations get appLocalizations;

  /// Список персонажей
  ListenableState<EntityState<List<CharacterCard>>> get characterCard;

  /// информация запроса
  ListenableState<EntityState<Info>> get info;

  /// Флаг загрузки
  ListenableState<EntityState<bool>> get loadIndicator;

  /// Гендер
  ListenableState<EntityState<Gender>> get gender;

  /// Статус
  ListenableState<EntityState<Status>> get status;

  /// scroll контроллер
  ScrollController get scroll;

  /// контроллер поля ввода имени
  TextEditingController get nameController;

  /// контроллер поля ввода расы
  TextEditingController get speciesController;

  /// выбор гендера
  void choiceGender(Gender gender);

  /// выбор статуса
  void choiceStatus(Status status);

  /// обновление данных
  void refresh();

  /// очистить все поля и перезагрузить
  void clearAndReload();
}

/// Фабрика страницы персонажей
CharacterPageWidgetModel initCharacterPageWidgetModelFactory(
  BuildContext context,
) {
  final scope = context.read<ICharacterPageScope>();
  final model = scope.model;
  final appLocalizations = AppLocalizations.of(context);
  return CharacterPageWidgetModel(
    model,
    appLocalizations: appLocalizations,
  );
}

/// WM страницы персонажей
class CharacterPageWidgetModel
    extends WidgetModel<CharacterPageWidget, CharacterPageModel>
    implements ICharacterPageWidgetModel {
  final EntityStateNotifier<List<CharacterCard>> _characterCard =
      EntityStateNotifier<List<CharacterCard>>()..content(List.empty());

  final EntityStateNotifier<Info> _info = EntityStateNotifier<Info>();

  final EntityStateNotifier<bool> _loadIndicator = EntityStateNotifier<bool>();

  final EntityStateNotifier<Gender> _gender = EntityStateNotifier<Gender>()
    ..content(Gender.none);

  final EntityStateNotifier<Status> _status = EntityStateNotifier<Status>()
    ..content(Status.none);

  @override
  final ScrollController scroll = ScrollController();

  @override
  final TextEditingController nameController = TextEditingController();

  @override
  final TextEditingController speciesController = TextEditingController();

  @override
  final AppLocalizations appLocalizations;

  @override
  ListenableState<EntityState<List<CharacterCard>>> get characterCard =>
      _characterCard;

  @override
  ListenableState<EntityState<Info>> get info => _info;

  @override
  ListenableState<EntityState<bool>> get loadIndicator => _loadIndicator;

  @override
  ListenableState<EntityState<Gender>> get gender => _gender;

  @override
  ListenableState<EntityState<Status>> get status => _status;

  /// страница
  int page = 1;

  /// Конструктор [CharacterPageWidgetModel]
  CharacterPageWidgetModel(
    CharacterPageModel model, {
    required this.appLocalizations,
  }) : super(model);

  @override
  void initWidgetModel() {
    _initLoad();
    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        _loadMore();
      }
    });
    super.initWidgetModel();
  }

  @override
  void dispose() {
    scroll.dispose();
    super.dispose();
  }

  @override
  Future<void> refresh() async {
    _initLoad();
  }

  @override
  Future<void> choiceGender(Gender gender) async {
    _gender.content(gender);
    await refresh();
  }

  @override
  Future<void> choiceStatus(Status status) async {
    _status.content(status);
    await refresh();
  }

  @override
  Future<void> clearAndReload() async {
    page = 1;
    _gender.content(Gender.none);
    _status.content(Status.none);
    nameController.text = '';
    speciesController.text = '';
    await refresh();
  }

  Future<void> _initLoad() async {
    try {
      _characterCard.loading();
      _info.loading();
      _loadIndicator.loading();
      _loadIndicator.content(false);
      final data = await model.getMultiFiltersInfo(
        page: page,
        gender: gender.value!.data! == Gender.none ? null : gender.value!.data!,
        status: status.value!.data! == Status.none ? null : status.value!.data!,
        name: nameController.text == '' ? null : nameController.text,
        species: speciesController.text == '' ? null : speciesController.text,
      );
      _characterCard.content(data.characters);
      _info.content(data.info);
    } on FormatException catch (e) {
      _characterCard.error(e);
    }
  }

  Future<void> _loadMore() async {
    if (info.value!.data!.next.isNotEmpty) {
      _loadIndicator.content(true);
      final tempContent = characterCard.value!.data!;

      await model
          .getMultiFiltersInfo(
        page: page + 1,
        gender: gender.value!.data! == Gender.none ? null : gender.value!.data!,
        status: status.value!.data! == Status.none ? null : status.value!.data!,
        name: nameController.text == '' ? null : nameController.text,
        species: speciesController.text == '' ? null : speciesController.text,
      )
          .then((value) {
        tempContent.addAll(value.characters);
        _characterCard.content(tempContent);
        page += 1;
      });
      _loadIndicator.content(false);
    }
  }
}
