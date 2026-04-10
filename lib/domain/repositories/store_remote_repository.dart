import 'package:dartz/dartz.dart';
import 'package:habilitaciontecnica_flutter_pragma/domain/entities/store_demo_data.dart';
import 'package:habilitaciontecnica_flutter_pragma/domain/failures/failure.dart';

/// Contrato para obtener el agregado de datos de demostración de la tienda remota.
abstract class StoreRemoteRepository {
  /// Compone productos, usuario y carrito, y expone la etiqueta de origen de los datos.
  Future<Either<Failure, StoreDemoData>> fetchDemoData();
}
