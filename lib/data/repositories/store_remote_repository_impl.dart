import 'package:dartz/dartz.dart';
import 'package:habilitaciontecnica_flutter_pragma/data/datasources/store_remote_datasource.dart';
import 'package:habilitaciontecnica_flutter_pragma/domain/entities/store_demo_data.dart';
import 'package:habilitaciontecnica_flutter_pragma/domain/failures/failure.dart';
import 'package:habilitaciontecnica_flutter_pragma/domain/repositories/store_remote_repository.dart';

/// Implementación que orquesta el [StoreRemoteDatasource] y unifica el resultado en [StoreDemoData].
class StoreRemoteRepositoryImpl implements StoreRemoteRepository {
  StoreRemoteRepositoryImpl(this._datasource);

  final StoreRemoteDatasource _datasource;

  static const String _labelPrimary = 'https://fakestoreapi.com';
  static const String _labelFallback =
      'https://dummyjson.com (respaldo en uno o más endpoints)';

  /// Solicita productos, usuario y carrito; si alguna petición falla, devuelve el primer [Failure].
  @override
  Future<Either<Failure, StoreDemoData>> fetchDemoData() async {
    final productsResult = await _datasource.fetchLimitedProducts(limit: 5);
    final sourcedProducts = _unwrap(productsResult);
    if (sourcedProducts == null) {
      return Left(_failureOrThrow(productsResult));
    }

    final userResult = await _datasource.fetchUserById(1);
    final sourcedUser = _unwrap(userResult);
    if (sourcedUser == null) {
      return Left(_failureOrThrow(userResult));
    }

    final cartResult = await _datasource.fetchCartById(1);
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
      StoreDemoData(
        products: sourcedProducts.value,
        user: sourcedUser.value,
        cart: sourcedCart.value,
        dataSourceLabel: label,
      ),
    );
  }

  T? _unwrap<T>(Either<Failure, T> either) {
    return either.fold((_) => null, (v) => v);
  }

  Failure _failureOrThrow<T>(Either<Failure, T> either) {
    return either.fold((f) => f, (_) => throw StateError('Se esperaba Left'));
  }
}
