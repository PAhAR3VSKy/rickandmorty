import 'package:flutter/material.dart';

/// Индикатор загрузки для проекта
class ActivityIndicator extends StatefulWidget {
  /// Яркость
  final Brightness brightness;

  /// Толщика (по дефолту 1.4)
  final double thickness;

  /// Размер
  final double size;

  /// Конструктор [ActivityIndicator]
  const ActivityIndicator({
    Key? key,
    this.brightness = Brightness.dark,
    this.thickness = 1.4,
    this.size = 20.0,
  }) : super(key: key);

  @override
  _ActivityIndicatorState createState() => _ActivityIndicatorState();
}

class _ActivityIndicatorState extends State<ActivityIndicator>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController
          ..reset()
          ..forward();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: CircularProgressIndicator(
          strokeWidth: widget.thickness,
          color: Colors.white60,
        ),
      ),
    );
  }
}
