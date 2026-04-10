/// Modelo que envuelve un valor obtenido de red e indica si provino de la API
/// principal (FakeStore) o del respaldo (DummyJson).
///
/// - [value]: Dato ya parseado (entidad o lista) listo para consumo aguas arriba.
/// - [fromFallback]: `true` si se usó DummyJson; `false` si la respuesta válida
///   vino de FakeStore.
class DataWithSourceModel<T> {
  const DataWithSourceModel({required this.value, required this.fromFallback});

  final T value;
  final bool fromFallback;
}
