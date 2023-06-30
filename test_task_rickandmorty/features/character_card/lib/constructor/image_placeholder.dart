import 'package:flutter/material.dart';

/// Заглушка изображения для загрузки и ошибки
class ImagePlaceholder {
  /// Заглушка изображения для загрузки и ошибки
  static final placeholder = Image.asset(
    'assets/images/image_placeholder.png',
    fit: BoxFit.cover,
    package: 'character_card',
  );
}
