import 'package:api_fakestore/src/parsers/dummy_json_parsers.dart'
    show parseDummyJsonProductsResponse;
import 'package:api_fakestore/src/parsers/fake_store_parsers.dart'
    show parseFakeStoreProductsResponse;
import 'package:api_fakestore/src/store_remote_gateway.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  group('parseFakeStoreProductsResponse', () {
    test('parsea array de productos', () {
      const body = '''
[{"id":1,"title":"A","price":9.99,"description":"d","category":"c","image":"http://x","rating":{"rate":4.5,"count":10}}]
''';
      final r = parseFakeStoreProductsResponse(body);
      expect(r.isRight(), isTrue);
      r.fold((_) => fail('left'), (list) {
        expect(list, hasLength(1));
        expect(list.single.title, 'A');
        expect(list.single.ratingRate, 4.5);
        expect(list.single.ratingCount, 10);
      });
    });
  });

  group('parseDummyJsonProductsResponse', () {
    test('parsea objeto con products', () {
      const body = '''
{"products":[{"id":2,"title":"B","price":1,"description":"","category":"x","thumbnail":"t.png","rating":3}]}
''';
      final r = parseDummyJsonProductsResponse(body);
      expect(r.isRight(), isTrue);
      r.fold((_) => fail('left'), (list) {
        expect(list.single.id, 2);
        expect(list.single.ratingRate, 3);
      });
    });
  });

  group('StoreRemoteGateway', () {
    test('usa respaldo cuando Fake Store falla con HTTP error', () async {
      final client = MockClient((request) async {
        if (request.url.host == 'fakestoreapi.com') {
          return http.Response('error', 503);
        }
        if (request.url.host == 'dummyjson.com' &&
            request.url.path.contains('products')) {
          return http.Response(
            '{"products":[{"id":1,"title":"FromDummy","price":1,"description":"","category":"c","thumbnail":"","rating":0}]}',
            200,
            headers: {'content-type': 'application/json'},
          );
        }
        return http.Response('not found', 404);
      });

      final gw = StoreRemoteGateway(httpClient: client);
      final result = await gw.fetchLimitedProducts(limit: 1);

      expect(result.isRight(), isTrue);
      result.fold((_) => fail('left'), (sourced) {
        expect(sourced.fromFallback, isTrue);
        expect(sourced.value.single.title, 'FromDummy');
      });
    });
  });
}
