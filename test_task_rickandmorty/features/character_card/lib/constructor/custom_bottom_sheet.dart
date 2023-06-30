import 'package:auto_route/auto_route.dart';
import 'package:character_card/constructor/wrapper_bottom_sheet.dart';
import 'package:flutter/material.dart';

/// Кастомный BottomSheet
class BottomSheetCustom extends StatelessWidget {
  /// Заголовок шторки
  final String? title;

  /// Подзаголовок шторки
  final String? subtitle;

  ///Виджет для отрисовки в центре шторки
  final Widget body;

  /// Конструктор [BottomSheetCustom]
  const BottomSheetCustom({
    required this.body,
    this.title,
    this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final titleWrapper = Column(
      children: [
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 4.0, 8.0, 4.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    0.0,
                    subtitle == null ? 10.0 : 8.0,
                    0.0,
                    8.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if ((title ?? '') != '')
                        Text(
                          title ?? '',
                        ),
                      if (subtitle != null) ...[
                        const SizedBox(
                          height: 4,
                        ),
                        RichText(
                          text: TextSpan(
                            text: subtitle ?? '',
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => context.router.pop(),
                child: SizedBox.square(
                  dimension: 44,
                  child: Center(
                    child: Icon(
                      Icons.clear,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          thickness: 0.5,
          height: 1,
        ),
      ],
    );
    final bodyWrapper = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        body,
        Divider(
          thickness: 0.5,
          height: 1,
        ),
      ],
    );
    final bottomWrapper = SizedBox(
      height: 44,
    );
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: BottomSheetWrapper(
        title: titleWrapper,
        body: bodyWrapper,
        bottom: bottomWrapper,
      ),
    );
  }
}
