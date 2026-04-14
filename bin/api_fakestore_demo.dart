import 'package:api_fakestore/api_fakestore.dart';
import 'package:habilitaciontecnica_flutter_pragma/core/debug/api_fakestore_demo_log.dart';

Future<void> main() async {
  final client = FakeStoreApiClient();
  final result = await client.fetchDemoData();
  // ignore: avoid_print
  logApiFakestoreDemoResult(result, print);
}
