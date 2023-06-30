import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:main_page/screen/main_screen_widget_model.dart';

/// Initialization screens
class MainScreen extends ElementaryWidget<MainScreenWidgetModel> {
  /// Create an instance [MainScreen].
  const MainScreen({
    Key? key,
    WidgetModelFactory wmFactory = initScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(MainScreenWidgetModel wm) {
    return AutoTabsRouter.tabBar(
      routes: wm.routes,
      builder: (context, child, controller) {
        final tabsRouter = context.tabsRouter;
        return Scaffold(
          appBar: AppBar(
            title: Text(wm.appLocalizations.rickAndMorty),
            centerTitle: true,
          ),
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: wm.navigationBarItems,
          ),
        );
      },
    );
  }
}
