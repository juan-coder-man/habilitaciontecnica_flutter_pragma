/// Línea de carrito: producto y cantidad asociada.
///
/// - [productId]: Identificador del producto en la API.
/// - [quantity]: Unidades solicitadas en esta línea.
class CartLineEntity {
  const CartLineEntity({required this.productId, required this.quantity});

  final int productId;
  final int quantity;
}

/// Entidad de dominio que representa un carrito de compras.
///
/// - [id]: Identificador del carrito en la API.
/// - [userId]: Usuario dueño del carrito.
/// - [dateIso]: Fecha del carrito en formato ISO 8601 (texto tal como viene del API).
/// - [lines]: Ítems del carrito con producto y cantidad.
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
