import 'package:habilitaciontecnica_flutter_pragma/core/debug/store_demo_log.dart';
import 'package:habilitaciontecnica_flutter_pragma/data/datasources/store_remote_datasource.dart';
import 'package:habilitaciontecnica_flutter_pragma/data/repositories/store_remote_repository_impl.dart';

Future<void> main() async {
  final repository = StoreRemoteRepositoryImpl(StoreRemoteDatasource());
  final result = await repository.fetchDemoData();

  // ignore: avoid_print
  logStoreDemoResult(result, print);
}
