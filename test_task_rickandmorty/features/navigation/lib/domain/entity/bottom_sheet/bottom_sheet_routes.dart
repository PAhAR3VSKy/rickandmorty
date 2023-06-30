import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

// /// All routes for the debug feature.
// const bottomSheetRoutes = CustomRoute<dynamic>(
//   name: 'BottomSheetRouter',
//   path: 'bottom_sheet',
//   page: DebugBottomSheet,
//   customRouteBuilder: modalSheetBuilder,
// );

/// Общий кастомный билдер для вызова bottom sheet
Route<T> modalSheetBuilder<T>(
  BuildContext context,
  Widget child,
  CustomPage<T> page,
) {
  return _modalSheetBuilder(context, child, page);
}

Route<T> _modalSheetBuilder<T>(
  BuildContext context,
  Widget child,
  CustomPage<T> page, {
  bool enableDrag = true,
}) {
  /// Запланированный отступ сверху
  final height = MediaQuery.of(context).size.height -
      (MediaQuery.of(context).padding.top + 44);
  return ModalBottomSheetRoute(
    isScrollControlled: false,
    useSafeArea: true,
    settings: page,
    enableDrag: enableDrag,
    builder: (context) => Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: height),
        child: child,
      ),
    ),
  );
}
