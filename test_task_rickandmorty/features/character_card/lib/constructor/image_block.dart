import 'package:cached_network_image/cached_network_image.dart';
import 'package:character_card/constructor/activity_indocator.dart';
import 'package:character_card/constructor/image_placeholder.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';

/// Изображение персонажа
class ImageBlock extends StatelessWidget {
  /// адрес изображения
  final String url;

  /// флаг, является ли персонаж избранным
  final ListenableState<EntityState<bool>> inFavorite;

  /// функция при добавлении/удаления персонажа из избранного
  final Function() onFavorite;

  /// конструктор [ImageBlock]
  const ImageBlock({
    required this.url,
    required this.inFavorite,
    required this.onFavorite,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = (MediaQuery.of(context).size.width / 2) - 28;
    return Stack(
      children: [
        Container(
          height: size,
          width: size,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
            color: Colors.white,
          ),
          child: OctoImage(
            fit: BoxFit.contain,
            height: size,
            width: size,
            memCacheWidth: size.toInt(),
            placeholderBuilder: (_) => ImagePlaceholder.placeholder,
            errorBuilder: (_, __, ___) => ImagePlaceholder.placeholder,
            image: url == ''
                ? ImagePlaceholder.placeholder.image
                : CachedNetworkImageProvider(url),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: InkResponse(
            onTap: onFavorite,
            child: EntityStateNotifierBuilder<bool>(
              listenableEntityState: inFavorite,
              loadingBuilder: (_, __) => const ActivityIndicator(),
              builder: (_, favorite) => Icon(
                favorite! ? Icons.favorite : Icons.favorite_border,
                size: 24,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
