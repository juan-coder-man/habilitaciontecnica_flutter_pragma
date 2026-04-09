class CartLineEntity {
  const CartLineEntity({required this.productId, required this.quantity});

  final int productId;
  final int quantity;
}

class CartEntity {
  const CartEntity({
    required this.id,
    required this.userId,
    required this.dateIso,
    required this.lines,
  });

  final int id;
  final int userId;
  final String dateIso;
  final List<CartLineEntity> lines;
}
