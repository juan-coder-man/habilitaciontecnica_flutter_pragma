/// Operaciones aritméticas básicas (contrato para inversión de dependencias).
abstract interface class Calculator {
  double add(double a, double b);

  double subtract(double a, double b);

  double multiply(double a, double b);

  double divide(double dividend, double divisor);
}

/// Implementación por defecto de [Calculator].
class BasicCalculator implements Calculator {
  const BasicCalculator();

  @override
  double add(double a, double b) => a + b;

  @override
  double subtract(double a, double b) => a - b;

  @override
  double multiply(double a, double b) => a * b;

  @override
  double divide(double dividend, double divisor) {
    if (divisor == 0) {
      throw ArgumentError.value(
        divisor,
        'divisor',
        'No se puede dividir por cero',
      );
    }
    return dividend / divisor;
  }
}
