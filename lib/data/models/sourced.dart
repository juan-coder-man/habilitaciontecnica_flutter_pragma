class Sourced<T> {
  const Sourced(this.value, this.fromFallback);

  final T value;
  final bool fromFallback;
}
