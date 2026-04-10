import 'package:habilitaciontecnica_flutter_pragma/domain/entities/cart_entity.dart';
import 'package:habilitaciontecnica_flutter_pragma/domain/entities/product_entity.dart';
import 'package:habilitaciontecnica_flutter_pragma/domain/entities/user_entity.dart';

/// Agregado de dominio con el conjunto de datos de demostración de la tienda.
///
/// - [products]: Lista de productos obtenidos del remoto (limitados en la capa de datos).
/// - [user]: Usuario asociado a la demostración.
/// - [cart]: Carrito asociado al usuario o escenario de demo.
/// - [dataSourceLabel]: Texto legible que indica si los datos provinieron de la API
///   principal (FakeStore) o del respaldo (DummyJson).
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
  final String dataSourceLabel;
}
