import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../failures/api_failure.dart';
import '../json_convert.dart';
import '../models/store_cart_model.dart';
import '../models/store_product_model.dart';
import '../models/store_user_model.dart';

/// Parsea la respuesta de DummyJSON: objeto con clave `products` (lista).
Either<ApiFailure, List<StoreProductModel>> parseDummyJsonProductsResponse(
  String body,
) {
  try {
    final decoded = jsonDecode(body);
    if (decoded is! Map<String, dynamic>) {
      return const Left(
        ParseFailure('Se esperaba un objeto JSON con productos'),
      );
    }
    final rawList = decoded['products'];
    if (rawList is! List<dynamic>) {
      return const Left(ParseFailure('Campo "products" inválido'));
    }
    final list = <StoreProductModel>[];
    for (final item in rawList) {
      if (item is! Map<String, dynamic>) {
        return const Left(ParseFailure('Elemento de producto inválido'));
      }
      list.add(_productFromDummyJsonMap(item));
    }
    return Right(list);
  } on FormatException catch (e) {
    return Left(ParseFailure('JSON inválido: ${e.message}'));
  }
}

/// Parsea un objeto usuario plano de DummyJSON (`firstName`, `lastName`, etc.).
Either<ApiFailure, StoreUserModel> parseDummyJsonUserResponse(String body) {
  try {
    final decoded = jsonDecode(body);
    if (decoded is! Map<String, dynamic>) {
      return const Left(ParseFailure('Se esperaba un objeto JSON de usuario'));
    }
    return Right(_userFromDummyJsonMap(decoded));
  } on FormatException catch (e) {
    return Left(ParseFailure('JSON inválido: ${e.message}'));
  }
}

/// Parsea un objeto carrito de DummyJSON (`products` como líneas).
Either<ApiFailure, StoreCartModel> parseDummyJsonCartResponse(String body) {
  try {
    final decoded = jsonDecode(body);
    if (decoded is! Map<String, dynamic>) {
      return const Left(ParseFailure('Se esperaba un objeto JSON de carrito'));
    }
    return Right(_cartFromDummyJsonMap(decoded));
  } on FormatException catch (e) {
    return Left(ParseFailure('JSON inválido: ${e.message}'));
  }
}

StoreProductModel _productFromDummyJsonMap(Map<String, dynamic> json) {
  final images = json['images'];
  String imageUrl = json['thumbnail']?.toString() ?? '';
  if (images is List<dynamic> && images.isNotEmpty) {
    imageUrl = images.first.toString();
  }
  final rating = jsonToDouble(json['rating']);
  return StoreProductModel(
    id: jsonToInt(json['id']),
    title: json['title']?.toString() ?? '',
    price: jsonToDouble(json['price']),
    description: json['description']?.toString() ?? '',
    category: json['category']?.toString() ?? '',
    imageUrl: imageUrl,
    ratingRate: rating,
    ratingCount: 0,
  );
}

StoreUserModel _userFromDummyJsonMap(Map<String, dynamic> json) {
  return StoreUserModel(
    id: jsonToInt(json['id']),
    email: json['email']?.toString() ?? '',
    username: json['username']?.toString() ?? '',
    firstName: json['firstName']?.toString() ?? '',
    lastName: json['lastName']?.toString() ?? '',
    phone: json['phone']?.toString() ?? '',
  );
}

StoreCartModel _cartFromDummyJsonMap(Map<String, dynamic> json) {
  final rawProducts = json['products'];
  final lines = <StoreCartLineModel>[];
  if (rawProducts is List<dynamic>) {
    for (final line in rawProducts) {
      if (line is Map<String, dynamic>) {
        final productId = jsonToInt(line['productId'] ?? line['id']);
        lines.add(
          StoreCartLineModel(
            productId: productId,
            quantity: jsonToInt(line['quantity']),
          ),
        );
      }
    }
  }
  return StoreCartModel(
    id: jsonToInt(json['id']),
    userId: jsonToInt(json['userId']),
    dateIso: json['date']?.toString() ?? '',
    lines: lines,
  );
}
