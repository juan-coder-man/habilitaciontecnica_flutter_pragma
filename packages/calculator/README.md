# calculator

Paquete Dart con operaciones aritméticas básicas sobre `double`. Expone un contrato (`Calculator`) y una implementación por defecto (`BasicCalculator`) para poder inyectar la dependencia en tests o en la app.

## Uso

```dart
import 'package:calculator/calculator.dart';

void main() {
  const Calculator calculator = BasicCalculator();

  final suma = calculator.add(12, 8);
  final resta = calculator.subtract(10, 3);
  final producto = calculator.multiply(4, 5);
  final cociente = calculator.divide(15, 2);
}
```

### API

| Símbolo           | Descripción                                                                    |
| ----------------- | ------------------------------------------------------------------------------ |
| `Calculator`      | Interfaz con `add`, `subtract`, `multiply`, `divide`.                          |
| `BasicCalculator` | Implementación concreta; `divide` lanza `ArgumentError` si el divisor es cero. |

## Dependencia en la app

En el `pubspec` de la aplicación:

```yaml
dependencies:
  calculator:
    path: packages/calculator
```

La app de ejemplo registra una demo en consola al arrancar ([`lib/core/debug/calculator_demo_log.dart`](../../lib/core/debug/calculator_demo_log.dart)) y expone un script sin UI:

```bash
dart run bin/calculator_demo.dart
```

## Tests

```bash
cd packages/calculator
dart pub get
dart test
```
