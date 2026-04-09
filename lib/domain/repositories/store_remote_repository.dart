import 'package:dartz/dartz.dart';
import 'package:habilitaciontecnica_flutter_pragma/domain/entities/store_demo_data.dart';
import 'package:habilitaciontecnica_flutter_pragma/domain/failures/failure.dart';

abstract class StoreRemoteRepository {
  Future<Either<Failure, StoreDemoData>> fetchDemoData();
}
