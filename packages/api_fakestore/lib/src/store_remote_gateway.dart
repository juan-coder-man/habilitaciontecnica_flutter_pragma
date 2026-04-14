import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';
import 'failures/api_failure.dart';
import 'http_body_client.dart';
import 'models/sourced_data_model.dart';
import 'models/store_cart_model.dart';
import 'models/store_product_model.dart';
import 'models/store_user_model.dart';
import 'parsers/dummy_json_parsers.dart';
import 'parsers/fake_store_parsers.dart';

/// Peticiones a Fake Store por recurso; si red, HTTP o parseo fallan, reintenta DummyJSON.
class StoreRemoteGateway {
  StoreRemoteGateway({http.Client? httpClient})
    : _http = HttpBodyClient(httpClient: httpClient);

  final HttpBodyClient _http;

  /// Lista de productos; JSON esperado: array en Fake Store, objeto con `products` en DummyJSON.
  Future<Either<ApiFailure, SourcedDataModel<List<StoreProductModel>>>>
  fetchLimitedProducts({int limit = 5}) async {
    final primaryUri = Uri.parse(
      '${FakeStoreEndpoints.fakeStoreBase}/products?limit=$limit',
    );
    final fallbackUri = Uri.parse(
      '${FakeStoreEndpoints.dummyJsonBase}/products?limit=$limit',
    );

    final primaryBody = await _http.getJsonBody(primaryUri);
    final fromPrimary = primaryBody
        .fold<Either<ApiFailure, SourcedDataModel<List<StoreProductModel>>>?>(
          (_) => null,
          (body) => parseFakeStoreProductsResponse(body).fold(
            (_) => null,
            (list) => Right(SourcedDataModel(value: list, fromFallback: false)),
          ),
        );
    if (fromPrimary != null) {
      return fromPrimary;
    }

    final fallbackBody = await _http.getJsonBody(fallbackUri);
    return fallbackBody.fold(Left.new, (body) {
      final parsed = parseDummyJsonProductsResponse(body);
      return parsed.map(
        (list) => SourcedDataModel(value: list, fromFallback: true),
      );
    });
  }

  /// Usuario por id; JSON esperado: objeto de usuario en ambos proveedores.
  Future<Either<ApiFailure, SourcedDataModel<StoreUserModel>>> fetchUserById(
    int id,
  ) async {
    final primaryUri = Uri.parse(
      '${FakeStoreEndpoints.fakeStoreBase}/users/$id',
    );
    final fallbackUri = Uri.parse(
      '${FakeStoreEndpoints.dummyJsonBase}/users/$id',
    );

    final primaryBody = await _http.getJsonBody(primaryUri);
    final fromPrimary = primaryBody
        .fold<Either<ApiFailure, SourcedDataModel<StoreUserModel>>?>(
          (_) => null,
          (body) => parseFakeStoreUserResponse(body).fold(
            (_) => null,
            (user) => Right(SourcedDataModel(value: user, fromFallback: false)),
          ),
        );
    if (fromPrimary != null) {
      return fromPrimary;
    }

    final fallbackBody = await _http.getJsonBody(fallbackUri);
    return fallbackBody.fold(Left.new, (body) {
      final parsed = parseDummyJsonUserResponse(body);
      return parsed.map(
        (user) => SourcedDataModel(value: user, fromFallback: true),
      );
    });
  }

  /// Carrito por id; JSON esperado: objeto con `products` como líneas.
  Future<Either<ApiFailure, SourcedDataModel<StoreCartModel>>> fetchCartById(
    int id,
  ) async {
    final primaryUri = Uri.parse(
      '${FakeStoreEndpoints.fakeStoreBase}/carts/$id',
    );
    final fallbackUri = Uri.parse(
      '${FakeStoreEndpoints.dummyJsonBase}/carts/$id',
    );

    final primaryBody = await _http.getJsonBody(primaryUri);
    final fromPrimary = primaryBody
        .fold<Either<ApiFailure, SourcedDataModel<StoreCartModel>>?>(
          (_) => null,
          (body) => parseFakeStoreCartResponse(body).fold(
            (_) => null,
            (cart) => Right(SourcedDataModel(value: cart, fromFallback: false)),
          ),
        );
    if (fromPrimary != null) {
      return fromPrimary;
    }

    final fallbackBody = await _http.getJsonBody(fallbackUri);
    return fallbackBody.fold(Left.new, (body) {
      final parsed = parseDummyJsonCartResponse(body);
      return parsed.map(
        (cart) => SourcedDataModel(value: cart, fromFallback: true),
      );
    });
  }
}
