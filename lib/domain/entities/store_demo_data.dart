import 'package:habilitaciontecnica_flutter_pragma/domain/entities/cart_entity.dart';
import 'package:habilitaciontecnica_flutter_pragma/domain/entities/product_entity.dart';
import 'package:habilitaciontecnica_flutter_pragma/domain/entities/user_entity.dart';

class StoreDemoData {
  const StoreDemoData({
    required this.products,
    required this.user,
    required this.cart,
    required this.dataSourceLabel,
  });

  final List<ProductEntity> products;
  final UserEntity user;
  final CartEntity cart;

  /// Indica si los datos provinieron de la API principal o del respaldo.
  final String dataSourceLabel;
}
