import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:habilitaciontecnica_flutter_pragma/domain/entities/cart_entity.dart';
import 'package:habilitaciontecnica_flutter_pragma/domain/entities/product_entity.dart';
import 'package:habilitaciontecnica_flutter_pragma/domain/entities/user_entity.dart';
import 'package:habilitaciontecnica_flutter_pragma/domain/failures/failure.dart';

Either<Failure, List<ProductEntity>> parseDummyJsonProductsResponse(
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
    final list = <ProductEntity>[];
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

Either<Failure, UserEntity> parseDummyJsonUserResponse(String body) {
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

Either<Failure, CartEntity> parseDummyJsonCartResponse(String body) {
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

ProductEntity _productFromDummyJsonMap(Map<String, dynamic> json) {
  final images = json['images'];
  String imageUrl = json['thumbnail']?.toString() ?? '';
  if (images is List<dynamic> && images.isNotEmpty) {
    imageUrl = images.first.toString();
  }
  final rating = _toDouble(json['rating']);
  return ProductEntity(
    id: _toInt(json['id']),
    title: json['title']?.toString() ?? '',
    price: _toDouble(json['price']),
    description: json['description']?.toString() ?? '',
    category: json['category']?.toString() ?? '',
    imageUrl: imageUrl,
    ratingRate: rating,
    ratingCount: 0,
  );
}

UserEntity _userFromDummyJsonMap(Map<String, dynamic> json) {
  return UserEntity(
    id: _toInt(json['id']),
    email: json['email']?.toString() ?? '',
    username: json['username']?.toString() ?? '',
    firstName: json['firstName']?.toString() ?? '',
    lastName: json['lastName']?.toString() ?? '',
    phone: json['phone']?.toString() ?? '',
  );
}

CartEntity _cartFromDummyJsonMap(Map<String, dynamic> json) {
  final rawProducts = json['products'];
  final lines = <CartLineEntity>[];
  if (rawProducts is List<dynamic>) {
    for (final line in rawProducts) {
      if (line is Map<String, dynamic>) {
        final productId = _toInt(line['productId'] ?? line['id']);
        lines.add(
          CartLineEntity(
            productId: productId,
            quantity: _toInt(line['quantity']),
          ),
        );
      }
    }
  }
  return CartEntity(
    id: _toInt(json['id']),
    userId: _toInt(json['userId']),
    dateIso: json['date']?.toString() ?? '',
    lines: lines,
  );
}

int _toInt(Object? value) {
  if (value is int) return value;
  if (value is double) return value.toInt();
  if (value is num) return value.toInt();
  return 0;
}

double _toDouble(Object? value) {
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is num) return value.toDouble();
  return 0;
}
