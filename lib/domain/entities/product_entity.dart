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
