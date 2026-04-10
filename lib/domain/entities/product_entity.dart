/// Entidad de dominio que representa un producto de la tienda.
///
/// - [id]: Identificador único del producto en la API.
/// - [title]: Nombre o título comercial del producto.
/// - [price]: Precio unitario del producto.
/// - [description]: Descripción detallada para mostrar en la UI.
/// - [category]: Categoría a la que pertenece el producto.
/// - [imageUrl]: URL de la imagen principal del producto.
/// - [ratingRate]: Puntaje promedio de valoración del producto.
/// - [ratingCount]: Cantidad total de valoraciones recibidas.
class ProductEntity {
  const ProductEntity({
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
