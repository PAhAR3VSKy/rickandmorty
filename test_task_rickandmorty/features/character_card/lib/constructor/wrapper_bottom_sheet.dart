import 'package:flutter/material.dart';

/// Обертка BS
class BottomSheetWrapper extends StatelessWidget {
  /// Заголовок BottomSheet
  final Widget? title;

  /// Тело BottomSheet
  final Widget? body;

  /// Нижняя часть BottomSheet
  final Widget? bottom;

  /// Конструктор [BottomSheetWrapper]
  const BottomSheetWrapper({
    required this.title,
    required this.body,
    required this.bottom,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        title ?? const SizedBox(),
        Flexible(child: SingleChildScrollView(child: body ?? const SizedBox())),
        bottom ?? const SizedBox(),
      ],
    );
  }
}
