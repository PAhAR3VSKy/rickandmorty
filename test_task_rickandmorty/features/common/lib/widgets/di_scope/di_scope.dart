import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Factory that returns the dependency scope.
typedef ScopeFactory<T> = T Function();

/// Di container. T - return type
class DiScope<T> extends StatefulWidget {
  /// Factory that returns the dependency scope.
  final ScopeFactory<T> factory;

  /// The widget below this widget in the tree.
  final Widget child;

  /// Create an instance [DiScope].
  const DiScope({
    required this.factory,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  _DiScopeState createState() => _DiScopeState<T>();
}

class _DiScopeState<T> extends State<DiScope<T>> {
  late T scope;

  @override
  void initState() {
    super.initState();
    scope = widget.factory();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<T>(
      create: (_) => scope,
      child: widget.child,
    );
  }
}

/// Оболочка со Scope над виджетом
class MultiDiScope extends StatelessWidget {

  /// Лист [MultiDiScopeItem]
  final List<MultiDiScopeItem> scopes;

  /// Виджет, который оборачивается в [MultiDiScope]
  final Widget child;

  /// Конструктор [MultiDiScope]
  const MultiDiScope({
    // required this.mainScope,
    required this.scopes,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget nestedDi = scopes.first.getScope(child);
    for (var i = 1; i < scopes.length; i++) {
      nestedDi = scopes[i].getScope(nestedDi);
    }
    return nestedDi;
  }
}

/// Класс, создающий Scope для [MultiDiScope]
class MultiDiScopeItem<T> {
  /// Factory that returns the dependency scope.
  final ScopeFactory<T> factory;


  /// Конструктор
  MultiDiScopeItem({required this.factory});

  /// Генерация Scope
  DiScope<T> getScope(Widget child) {
    final scope = factory();
    return DiScope<T>(
      key: ObjectKey(scope),
      factory: () => scope,
      child: child,
    );
  }
}
