/// Línea de carrito: producto y cantidad.
///
/// - [productId]: Identificador del producto en la API.
/// - [quantity]: Unidades en esta línea.
class StoreCartLineModel {
  const StoreCartLineModel({required this.productId, required this.quantity});

  final int productId;
  final int quantity;
}

/// Carrito de compras con sus líneas.
///
/// - [id]: Identificador del carrito en la API.
/// - [userId]: Usuario dueño del carrito.
/// - [dateIso]: Fecha en formato ISO 8601 (texto tal como viene del API).
/// - [lines]: Ítems del carrito.
class StoreCartModel {
  const StoreCartModel({
    required this.id,
    required this.userId,
    required this.dateIso,
    required this.lines,
  });

  final int id;
  final int userId;
  final String dateIso;
  final List<StoreCartLineModel> lines;
}
