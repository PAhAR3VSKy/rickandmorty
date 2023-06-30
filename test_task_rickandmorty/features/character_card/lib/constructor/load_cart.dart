import 'package:character_card/constructor/animation_part.dart';
import 'package:flutter/material.dart';

/// загружаемая карточка
class LoadCard extends StatelessWidget {
  ///конструктор
  const LoadCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(14)),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox.square(
            dimension: (MediaQuery.of(context).size.width / 2) - 28,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
              child: Image.asset(
                'assets/images/image_placeholder.png',
                fit: BoxFit.cover,
                package: 'character_card',
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: AnimationPart(
                  width: MediaQuery.of(context).size.width * 0.404,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  children: const [
                    AnimationPart(
                      width: 36,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    AnimationPart(
                      width: 36,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 13.5,
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              color: Colors.black26,
            ),
            height: 44,
            width: MediaQuery.of(context).size.width * 0.424,
            child: const Center(
              child: AnimationPart(
                width: 41,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
