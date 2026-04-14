import 'package:api_fakestore/api_fakestore.dart';
import 'package:dartz/dartz.dart';

void logApiFakestoreDemoResult(
  Either<ApiFailure, FakeStoreDemoDataModel> result,
  void Function(String message) write,
) {
  result.fold(
    (failure) => write(_failureText(failure)),
    (data) => write(_successText(data)),
  );
}

String _failureText(ApiFailure failure) {
  final buffer = StringBuffer()
    ..writeln('')
    ..writeln('=== Error al obtener datos de la tienda (api_fakestore) ===')
    ..writeln(_failureMessage(failure))
    ..writeln('');
  return buffer.toString();
}

String _failureMessage(ApiFailure failure) {
  return switch (failure) {
    NetworkFailure(:final message) => 'Red: $message',
    HttpFailure(:final statusCode, :final message) =>
      'HTTP $statusCode: $message',
    ParseFailure(:final message) => 'Parseo: $message',
  };
}

String _successText(FakeStoreDemoDataModel data) {
  final buffer = StringBuffer()
    ..writeln('')
    ..writeln('============================================================')
    ..writeln(' Demo Fake Store API (paquete api_fakestore)')
    ..writeln(' Origen: ${data.dataSourceLabel}')
    ..writeln('============================================================')
    ..writeln('')
    ..writeln('--- Productos (GET /products?limit=5) ---')
    ..writeln('');

  for (var i = 0; i < data.products.length; i++) {
    buffer.writeln(_formatProduct(i + 1, data.products[i]));
  }

  buffer
    ..writeln('')
    ..writeln('--- Usuario (GET /users/1) ---')
    ..writeln('')
    ..writeln(_formatUser(data.user))
    ..writeln('')
    ..writeln('--- Carrito (GET /carts/1) ---')
    ..writeln('')
    ..writeln(_formatCart(data.cart))
    ..writeln('')
    ..writeln('============================================================')
    ..writeln('');

  return buffer.toString();
}

String _formatProduct(int index, StoreProductModel p) {
  return '''
[$index] ${p.title}
      Id: ${p.id}
      Precio: \$${p.price.toStringAsFixed(2)}
      Categoría: ${p.category}
      Valoración: ${p.ratingRate} (${p.ratingCount} valoraciones)
      Descripción: ${_shorten(p.description, 120)}
      Imagen: ${p.imageUrl}
''';
}

String _formatUser(StoreUserModel u) {
  return '''
  Id: ${u.id}
  Nombre: ${u.fullName}
  Usuario: ${u.username}
  Email: ${u.email}
  Teléfono: ${u.phone}
''';
}

String _formatCart(StoreCartModel c) {
  final lines = StringBuffer()
    ..writeln('  Id carrito: ${c.id}')
    ..writeln('  Id usuario: ${c.userId}')
    ..writeln('  Fecha: ${c.dateIso.isEmpty ? '(no disponible)' : c.dateIso}')
    ..writeln('  Líneas:');
  for (final line in c.lines) {
    lines.writeln('    · productoId ${line.productId} × ${line.quantity}');
  }
  return lines.toString();
}

String _shorten(String text, int maxChars) {
  final t = text.trim();
  if (t.length <= maxChars) return t;
  return '${t.substring(0, maxChars)}…';
}
