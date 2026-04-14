/// URLs base de Fake Store y DummyJSON, y timeout por petición.
abstract final class FakeStoreEndpoints {
  static const String fakeStoreBase = 'https://fakestoreapi.com';
  static const String dummyJsonBase = 'https://dummyjson.com';
  static const Duration requestTimeout = Duration(seconds: 15);
}
