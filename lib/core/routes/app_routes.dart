import 'package:flutter/material.dart';
import 'package:habilitaciontecnica_flutter_pragma/domain/entities/item_entity.dart';
import 'package:habilitaciontecnica_flutter_pragma/presentation/details/details_screen.dart';
import 'package:habilitaciontecnica_flutter_pragma/presentation/form/form_screen.dart';
import 'package:habilitaciontecnica_flutter_pragma/presentation/home/home_screen.dart';

abstract class AppRoutes {
  static const String home = '/';
  static const String details = '/details';
  static const String form = '/form';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const HomeScreen(),
        );
      case details:
        final item = settings.arguments as ItemEntity?;
        if (item == null) {
          return MaterialPageRoute<void>(
            settings: settings,
            builder: (_) => const HomeScreen(),
          );
        }
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => DetailsScreen(item: item),
        );
      case form:
        final editingItem = settings.arguments as ItemEntity?;
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => FormScreen(editingItem: editingItem),
        );
      default:
        return null;
    }
  }
}
