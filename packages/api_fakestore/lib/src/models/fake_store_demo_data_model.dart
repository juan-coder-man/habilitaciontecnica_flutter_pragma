import 'store_cart_model.dart';
import 'store_product_model.dart';
import 'store_user_model.dart';

/// Conjunto de datos de demostración: productos, usuario y carrito.
///
/// - [products]: Lista de productos (cantidad acotada por la petición).
/// - [user]: Usuario asociado a la demostración.
/// - [cart]: Carrito asociado al escenario de demo.
/// - [dataSourceLabel]: Indica si la respuesta usó solo Fake Store o hubo
///   respaldo en DummyJSON en al menos un recurso.
class FakeStoreDemoDataModel {
  const FakeStoreDemoDataModel({
    required this.products,
    required this.user,
    required this.cart,
    required this.dataSourceLabel,
  });

  final List<StoreProductModel> products;
  final StoreUserModel user;
  final StoreCartModel cart;
  final String dataSourceLabel;
}
