import 'package:api_fakestore/api_fakestore.dart';
import 'package:flutter/material.dart';
import 'package:habilitaciontecnica_flutter_pragma/domain/entities/item_entity.dart';
import 'package:habilitaciontecnica_flutter_pragma/presentation/details/details_screen.dart';
import 'package:habilitaciontecnica_flutter_pragma/presentation/form/form_screen.dart';
import 'package:habilitaciontecnica_flutter_pragma/presentation/home/home_hub_screen.dart';
import 'package:habilitaciontecnica_flutter_pragma/presentation/items/items_list_screen.dart';
import 'package:habilitaciontecnica_flutter_pragma/presentation/store_package/store_package_screen.dart';
import 'package:habilitaciontecnica_flutter_pragma/presentation/store_package/store_product_detail_screen.dart';

abstract class AppRoutes {
  static const String home = '/';
  static const String items = '/items';
  static const String details = '/details';
  static const String form = '/form';
  static const String storePackage = '/store-package';
  static const String storePackageProductDetail =
      '/store-package/product-detail';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const HomeHubScreen(),
        );
      case items:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const ItemsListScreen(),
        );
      case details:
        final item = settings.arguments as ItemEntity?;
        if (item == null) {
          return MaterialPageRoute<void>(
            settings: settings,
            builder: (_) => const ItemsListScreen(),
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
      case storePackage:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const StorePackageScreen(),
        );
      case storePackageProductDetail:
        final product = settings.arguments as StoreProductModel?;
        if (product == null) {
          return MaterialPageRoute<void>(
            settings: settings,
            builder: (_) => const StorePackageScreen(),
          );
        }
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => StoreProductDetailScreen(product: product),
        );
      default:
        return null;
    }
  }
}
