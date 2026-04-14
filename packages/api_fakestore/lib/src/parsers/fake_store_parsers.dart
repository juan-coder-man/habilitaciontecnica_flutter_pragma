import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../failures/api_failure.dart';
import '../json_convert.dart';
import '../models/store_cart_model.dart';
import '../models/store_product_model.dart';
import '../models/store_user_model.dart';

/// Parsea la respuesta de Fake Store: array JSON de objetos producto.
Either<ApiFailure, List<StoreProductModel>> parseFakeStoreProductsResponse(
  String body,
) {
  try {
    final decoded = jsonDecode(body);
    if (decoded is! List<dynamic>) {
      return const Left(ParseFailure('Se esperaba un array JSON de productos'));
    }
    final list = <StoreProductModel>[];
    for (final item in decoded) {
      if (item is! Map<String, dynamic>) {
        return const Left(ParseFailure('Elemento de producto inválido'));
      }
      list.add(_productFromFakeStoreMap(item));
    }
    return Right(list);
  } on FormatException catch (e) {
    return Left(ParseFailure('JSON inválido: ${e.message}'));
  }
}

/// Parsea un objeto usuario de Fake Store (incluye `name` anidado).
Either<ApiFailure, StoreUserModel> parseFakeStoreUserResponse(String body) {
  try {
    final decoded = jsonDecode(body);
    if (decoded is! Map<String, dynamic>) {
      return const Left(ParseFailure('Se esperaba un objeto JSON de usuario'));
    }
    return Right(_userFromFakeStoreMap(decoded));
  } on FormatException catch (e) {
    return Left(ParseFailure('JSON inválido: ${e.message}'));
  }
}

/// Parsea un objeto carrito de Fake Store (`products` como líneas).
Either<ApiFailure, StoreCartModel> parseFakeStoreCartResponse(String body) {
  try {
    final decoded = jsonDecode(body);
    if (decoded is! Map<String, dynamic>) {
      return const Left(ParseFailure('Se esperaba un objeto JSON de carrito'));
    }
    return Right(_cartFromFakeStoreMap(decoded));
  } on FormatException catch (e) {
    return Left(ParseFailure('JSON inválido: ${e.message}'));
  }
}

StoreProductModel _productFromFakeStoreMap(Map<String, dynamic> json) {
  final rating = json['rating'];
  double rate = 0;
  int count = 0;
  if (rating is Map<String, dynamic>) {
    rate = jsonToDouble(rating['rate']);
    count = jsonToInt(rating['count']);
  }
  return StoreProductModel(
    id: jsonToInt(json['id']),
    title: json['title']?.toString() ?? '',
    price: jsonToDouble(json['price']),
    description: json['description']?.toString() ?? '',
    category: json['category']?.toString() ?? '',
    imageUrl: json['image']?.toString() ?? '',
    ratingRate: rate,
    ratingCount: count,
  );
}

StoreUserModel _userFromFakeStoreMap(Map<String, dynamic> json) {
  final name = json['name'];
  String first = '';
  String last = '';
  if (name is Map<String, dynamic>) {
    first = name['firstname']?.toString() ?? '';
    last = name['lastname']?.toString() ?? '';
  }
  return StoreUserModel(
    id: jsonToInt(json['id']),
    email: json['email']?.toString() ?? '',
    username: json['username']?.toString() ?? '',
    firstName: first,
    lastName: last,
    phone: json['phone']?.toString() ?? '',
  );
}

StoreCartModel _cartFromFakeStoreMap(Map<String, dynamic> json) {
  final rawProducts = json['products'];
  final lines = <StoreCartLineModel>[];
  if (rawProducts is List<dynamic>) {
    for (final line in rawProducts) {
      if (line is Map<String, dynamic>) {
        lines.add(
          StoreCartLineModel(
            productId: jsonToInt(line['productId']),
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
