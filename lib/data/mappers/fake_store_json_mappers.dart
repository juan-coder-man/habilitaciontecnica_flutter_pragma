import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:habilitaciontecnica_flutter_pragma/domain/entities/cart_entity.dart';
import 'package:habilitaciontecnica_flutter_pragma/domain/entities/product_entity.dart';
import 'package:habilitaciontecnica_flutter_pragma/domain/entities/user_entity.dart';
import 'package:habilitaciontecnica_flutter_pragma/domain/failures/failure.dart';

Either<Failure, List<ProductEntity>> parseFakeStoreProductsResponse(
  String body,
) {
  try {
    final decoded = jsonDecode(body);
    if (decoded is! List<dynamic>) {
      return const Left(ParseFailure('Se esperaba un array JSON de productos'));
    }
    final list = <ProductEntity>[];
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

Either<Failure, UserEntity> parseFakeStoreUserResponse(String body) {
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

Either<Failure, CartEntity> parseFakeStoreCartResponse(String body) {
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

ProductEntity _productFromFakeStoreMap(Map<String, dynamic> json) {
  final rating = json['rating'];
  double rate = 0;
  int count = 0;
  if (rating is Map<String, dynamic>) {
    rate = _toDouble(rating['rate']);
    count = _toInt(rating['count']);
  }
  return ProductEntity(
    id: _toInt(json['id']),
    title: json['title']?.toString() ?? '',
    price: _toDouble(json['price']),
    description: json['description']?.toString() ?? '',
    category: json['category']?.toString() ?? '',
    imageUrl: json['image']?.toString() ?? '',
    ratingRate: rate,
    ratingCount: count,
  );
}

UserEntity _userFromFakeStoreMap(Map<String, dynamic> json) {
  final name = json['name'];
  String first = '';
  String last = '';
  if (name is Map<String, dynamic>) {
    first = name['firstname']?.toString() ?? '';
    last = name['lastname']?.toString() ?? '';
  }
  return UserEntity(
    id: _toInt(json['id']),
    email: json['email']?.toString() ?? '',
    username: json['username']?.toString() ?? '',
    firstName: first,
    lastName: last,
    phone: json['phone']?.toString() ?? '',
  );
}

CartEntity _cartFromFakeStoreMap(Map<String, dynamic> json) {
  final rawProducts = json['products'];
  final lines = <CartLineEntity>[];
  if (rawProducts is List<dynamic>) {
    for (final line in rawProducts) {
      if (line is Map<String, dynamic>) {
        lines.add(
          CartLineEntity(
            productId: _toInt(line['productId']),
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
