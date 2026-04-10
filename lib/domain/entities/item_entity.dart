/// Entidad de dominio para un ítem genérico de lista (p. ej. contenido local).
///
/// - [id]: Identificador único del ítem.
/// - [title]: Título breve mostrado en listas o cabeceras.
/// - [description]: Texto descriptivo o detalle adicional.
/// - [createdAt]: Momento de creación del registro.
class ItemEntity {
  const ItemEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  final String id;
  final String title;
  final String description;
  final DateTime createdAt;

  ItemEntity copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
  }) {
    return ItemEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemEntity && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
