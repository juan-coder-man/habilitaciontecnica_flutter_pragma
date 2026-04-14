/// Producto de tienda mapeado desde Fake Store o DummyJSON.
///
/// - [id]: Identificador del producto en la API.
/// - [title]: Nombre o título comercial.
/// - [price]: Precio unitario.
/// - [description]: Descripción detallada.
/// - [category]: Categoría a la que pertenece.
/// - [imageUrl]: URL de la imagen principal.
/// - [ratingRate]: Puntaje medio de valoración.
/// - [ratingCount]: Cantidad de valoraciones (puede ser 0 si el proveedor no lo aporta).
class StoreProductModel {
  const StoreProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.ratingRate,
    required this.ratingCount,
  });

  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String imageUrl;
  final double ratingRate;
  final int ratingCount;
}
