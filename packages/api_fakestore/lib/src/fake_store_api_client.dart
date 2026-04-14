import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import 'failures/api_failure.dart';
import 'models/fake_store_demo_data_model.dart';
import 'models/sourced_data_model.dart';
import 'store_remote_gateway.dart';

/// Fachada pública: consulta Fake Store y, si falla, reintenta con DummyJSON.
///
/// [httpClient] es opcional para inyectar un mock en tests; si es null se usa
/// el [http.Client] por defecto.
class FakeStoreApiClient {
  FakeStoreApiClient({http.Client? httpClient})
    : _gateway = StoreRemoteGateway(httpClient: httpClient);

  final StoreRemoteGateway _gateway;

  static const String _labelPrimary = 'https://fakestoreapi.com';
  static const String _labelFallback =
      'https://dummyjson.com (respaldo en uno o más endpoints)';

  /// Obtiene productos, un usuario y un carrito en secuencia.
  ///
  /// - [productLimit]: Cantidad máxima de productos solicitada al endpoint.
  /// - [userId]: Identificador del usuario (`GET /users/{id}`).
  /// - [cartId]: Identificador del carrito (`GET /carts/{id}`).
  ///
  /// Si cualquier llamada devuelve [Left], el resultado es ese fallo (no se
  /// continúa). Si todo es correcto, [FakeStoreDemoDataModel.dataSourceLabel] indica
  /// si DummyJSON se usó en al menos uno de los tres recursos.
  Future<Either<ApiFailure, FakeStoreDemoDataModel>> fetchDemoData({
    int productLimit = 5,
    int userId = 1,
    int cartId = 1,
  }) async {
    final productsResult = await _gateway.fetchLimitedProducts(
      limit: productLimit,
    );
    final sourcedProducts = _unwrap(productsResult);
    if (sourcedProducts == null) {
      return Left(_failureOrThrow(productsResult));
    }

    final userResult = await _gateway.fetchUserById(userId);
    final sourcedUser = _unwrap(userResult);
    if (sourcedUser == null) {
      return Left(_failureOrThrow(userResult));
    }

    final cartResult = await _gateway.fetchCartById(cartId);
    final sourcedCart = _unwrap(cartResult);
    if (sourcedCart == null) {
      return Left(_failureOrThrow(cartResult));
    }

    final anyFallback =
        sourcedProducts.fromFallback ||
        sourcedUser.fromFallback ||
        sourcedCart.fromFallback;
    final label = anyFallback ? _labelFallback : _labelPrimary;

    return Right(
      FakeStoreDemoDataModel(
        products: sourcedProducts.value,
        user: sourcedUser.value,
        cart: sourcedCart.value,
        dataSourceLabel: label,
      ),
    );
  }

  SourcedDataModel<T>? _unwrap<T>(
    Either<ApiFailure, SourcedDataModel<T>> either,
  ) {
    return either.fold((_) => null, (v) => v);
  }

  ApiFailure _failureOrThrow<T>(
    Either<ApiFailure, SourcedDataModel<T>> either,
  ) {
    return either.fold((f) => f, (_) => throw StateError('Se esperaba Left'));
  }
}
