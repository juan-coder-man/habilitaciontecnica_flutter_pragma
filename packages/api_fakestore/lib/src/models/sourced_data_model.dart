/// Valor obtenido de red con indicador de proveedor (principal o respaldo).
///
/// - [value]: Dato ya parseado listo para usar.
/// - [fromFallback]: `true` si la respuesta válida vino de DummyJSON;
///   `false` si vino de Fake Store.
class SourcedDataModel<T> {
  const SourcedDataModel({required this.value, required this.fromFallback});

  final T value;
  final bool fromFallback;
}
