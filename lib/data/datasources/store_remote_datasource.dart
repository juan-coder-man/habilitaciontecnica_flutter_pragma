import 'package:dartz/dartz.dart';
import 'package:habilitaciontecnica_flutter_pragma/core/constants/store_api_constants.dart';
import 'package:habilitaciontecnica_flutter_pragma/data/mappers/dummy_json_mappers.dart';
import 'package:habilitaciontecnica_flutter_pragma/data/mappers/fake_store_json_mappers.dart';
import 'package:habilitaciontecnica_flutter_pragma/data/models/data_with_source_model.dart';
import 'package:habilitaciontecnica_flutter_pragma/domain/entities/cart_entity.dart';
import 'package:habilitaciontecnica_flutter_pragma/domain/entities/product_entity.dart';
import 'package:habilitaciontecnica_flutter_pragma/domain/entities/user_entity.dart';
import 'package:habilitaciontecnica_flutter_pragma/domain/failures/failure.dart';
import 'package:http/http.dart' as http;

/// Fuente remota que consulta FakeStore y, si falla el parseo o la petición,
/// reintenta contra DummyJson devolviendo [DataWithSourceModel] con la procedencia.
class StoreRemoteDatasource {
  /// [httpClient] opcional para pruebas; por defecto se usa [http.Client].
  StoreRemoteDatasource({http.Client? httpClient})
    : _client = httpClient ?? http.Client();

  final http.Client _client;

  /// Obtiene hasta [limit] productos, priorizando FakeStore y usando DummyJson como respaldo.
  Future<Either<Failure, DataWithSourceModel<List<ProductEntity>>>>
  fetchLimitedProducts({int limit = 5}) async {
    final primaryUri = Uri.parse(
      '${StoreApiConstants.fakeStoreBase}/products?limit=$limit',
    );
    final fallbackUri = Uri.parse(
      '${StoreApiConstants.dummyJsonBase}/products?limit=$limit',
    );

    final primaryBody = await _getBody(primaryUri);
    final fromPrimary = primaryBody
        .fold<Either<Failure, DataWithSourceModel<List<ProductEntity>>>?>(
          (_) => null,
          (body) => parseFakeStoreProductsResponse(body).fold(
            (_) => null,
            (list) =>
                Right(DataWithSourceModel(value: list, fromFallback: false)),
          ),
        );
    if (fromPrimary != null) {
      return fromPrimary;
    }

    final fallbackBody = await _getBody(fallbackUri);
    return fallbackBody.fold(Left.new, (body) {
      final parsed = parseDummyJsonProductsResponse(body);
      return parsed.map(
        (list) => DataWithSourceModel(value: list, fromFallback: true),
      );
    });
  }

  /// Obtiene el usuario [id] por la misma estrategia principal / respaldo.
  Future<Either<Failure, DataWithSourceModel<UserEntity>>> fetchUserById(
    int id,
  ) async {
    final primaryUri = Uri.parse(
      '${StoreApiConstants.fakeStoreBase}/users/$id',
    );
    final fallbackUri = Uri.parse(
      '${StoreApiConstants.dummyJsonBase}/users/$id',
    );

    final primaryBody = await _getBody(primaryUri);
    final fromPrimary = primaryBody
        .fold<Either<Failure, DataWithSourceModel<UserEntity>>?>(
          (_) => null,
          (body) => parseFakeStoreUserResponse(body).fold(
            (_) => null,
            (user) =>
                Right(DataWithSourceModel(value: user, fromFallback: false)),
          ),
        );
    if (fromPrimary != null) {
      return fromPrimary;
    }

    final fallbackBody = await _getBody(fallbackUri);
    return fallbackBody.fold(Left.new, (body) {
      final parsed = parseDummyJsonUserResponse(body);
      return parsed.map(
        (user) => DataWithSourceModel(value: user, fromFallback: true),
      );
    });
  }

  /// Obtiene el carrito [id] por la misma estrategia principal / respaldo.
  Future<Either<Failure, DataWithSourceModel<CartEntity>>> fetchCartById(
    int id,
  ) async {
    final primaryUri = Uri.parse(
      '${StoreApiConstants.fakeStoreBase}/carts/$id',
    );
    final fallbackUri = Uri.parse(
      '${StoreApiConstants.dummyJsonBase}/carts/$id',
    );

    final primaryBody = await _getBody(primaryUri);
    final fromPrimary = primaryBody
        .fold<Either<Failure, DataWithSourceModel<CartEntity>>?>(
          (_) => null,
          (body) => parseFakeStoreCartResponse(body).fold(
            (_) => null,
            (cart) =>
                Right(DataWithSourceModel(value: cart, fromFallback: false)),
          ),
        );
    if (fromPrimary != null) {
      return fromPrimary;
    }

    final fallbackBody = await _getBody(fallbackUri);
    return fallbackBody.fold(Left.new, (body) {
      final parsed = parseDummyJsonCartResponse(body);
      return parsed.map(
        (cart) => DataWithSourceModel(value: cart, fromFallback: true),
      );
    });
  }

  Future<Either<Failure, String>> _getBody(Uri uri) async {
    try {
      final response = await _client
          .get(uri, headers: const {'Accept': 'application/json'})
          .timeout(StoreApiConstants.requestTimeout);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Right(response.body);
      }
      return Left(
        HttpFailure(
          response.statusCode,
          'Respuesta HTTP ${response.statusCode} para $uri',
        ),
      );
    } on Exception catch (e) {
      return Left(NetworkFailure('Error de red al consultar $uri: $e'));
    }
  }
}
