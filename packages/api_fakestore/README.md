# api_fakestore

Paquete Dart (sin dependencia de Flutter) que consulta la [Fake Store API](https://fakestoreapi.com) y, si la petición o el parseo fallan, reintenta contra [DummyJSON](https://dummyjson.com) con rutas equivalentes.

## Dependencias

- `http`: cliente HTTP.
- `dartz`: `Either<ApiFailure, T>` para errores tipados.

## Uso

```dart
import 'package:api_fakestore/api_fakestore.dart';

Future<void> main() async {
  final client = FakeStoreApiClient();
  final result = await client.fetchDemoData(productLimit: 5);

  result.fold(
    (failure) => print('Error: ${failure.message}'),
    (data) {
      print('Origen: ${data.dataSourceLabel}');
      for (final p in data.products) {
        print('${p.title} — \$${p.price}');
      }
    },
  );
}
```

### API pública

| Símbolo                                                                                           | Descripción                                                                                                                     |
| ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| `FakeStoreApiClient`                                                                              | Fachada con `http.Client` opcional (inyectable para tests).                                                                     |
| `fetchDemoData`                                                                                   | Obtiene productos (`limit`), usuario y carrito por id (por defecto `1`). Devuelve `Either<ApiFailure, FakeStoreDemoDataModel>`. |
| `FakeStoreDemoDataModel`                                                                          | `products`, `user`, `cart`, `dataSourceLabel` (texto que indica si hubo respaldo).                                              |
| `StoreProductModel`, `StoreUserModel`, `StoreCartModel`, `StoreCartLineModel`, `SourcedDataModel` | Modelos inmutables de transporte (sin duplicar entidades de dominio de la app).                                                 |
| `ApiFailure`                                                                                      | `NetworkFailure`, `HttpFailure`, `ParseFailure`.                                                                                |

### Comportamiento

- Timeout: 15 segundos por petición.
- Cabecera `Accept: application/json`.
- Por cada recurso se intenta primero `fakestoreapi.com`; si falla red, HTTP no exitoso o el JSON no es válido para el parser de Fake Store, se consulta `dummyjson.com`.

## Tests

Desde esta carpeta:

```bash
dart pub get
dart test
```

## Publicar / consumir desde Git

En el `pubspec` de la app:

```yaml
dependencies:
  api_fakestore:
    git:
      url: https://github.com/juan-coder-man/habilitaciontecnica_flutter_pragma
      path: packages/api_fakestore
```
