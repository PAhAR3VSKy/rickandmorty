import 'package:flutter/material.dart';

/// Widget "Нет интернета"
class DefaultErrorWidget extends StatelessWidget {
  ///  функция, отрабатывающая при нажатии на кнопку обновить
  final VoidCallback? onTap;

  /// текст на кнопке
  final String? buttonText;

  /// Заголовок
  final String? title;

  /// Описание
  final String? description;

  /// кастомная ширина
  final double? customWidth;

  /// базовый конструктор [DefaultErrorWidget]
  const DefaultErrorWidget({
    this.onTap,
    this.title,
    this.description,
    this.buttonText,
    this.customWidth,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ColoredBox(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/image_placeholder.png',
              fit: BoxFit.cover,
              package: 'character_card',
            ),
            if (title != null)
              Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  bottom: 8,
                ),
                child: Text(
                  title!,
                  textAlign: TextAlign.center,
                ),
              ),
            if (description != null)
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 16,
                ),
                child: Text(
                  description!,
                  textAlign: TextAlign.center,
                ),
              ),
            if (buttonText != null)
              SizedBox(
                child: ElevatedButton(
                  onPressed: () => onTap?.call(),
                  child: Text(buttonText!),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
