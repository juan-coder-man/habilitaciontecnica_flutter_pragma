/// Convierte valores JSON numéricos heterogéneos a [int]; si no aplica, devuelve 0.
int jsonToInt(Object? value) {
  if (value is int) return value;
  if (value is double) return value.toInt();
  if (value is num) return value.toInt();
  return 0;
}

/// Convierte valores JSON numéricos heterogéneos a [double]; si no aplica, devuelve 0.
double jsonToDouble(Object? value) {
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is num) return value.toDouble();
  return 0;
}
