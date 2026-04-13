import 'package:calculator/calculator.dart';

void logCalculatorDemo(
  void Function(String message) write, {
  Calculator calculator = const BasicCalculator(),
}) {
  final buffer = StringBuffer()
    ..writeln('')
    ..writeln('============================================================')
    ..writeln(' Demo package calculator')
    ..writeln('============================================================')
    ..writeln('');

  buffer.writeln('Suma:       12 + 8 = ${calculator.add(12, 8)}');
  buffer.writeln('Resta:      10 - 3 = ${calculator.subtract(10, 3)}');
  buffer.writeln('Multiplica: 4 * 5 = ${calculator.multiply(4, 5)}');
  buffer.writeln('Divide:     15 / 2 = ${calculator.divide(15, 2)}');
  buffer.writeln('');
  buffer.writeln('División por cero (esperado: error):');
  try {
    calculator.divide(1, 0);
    buffer.writeln('  (no debería alcanzarse)');
  } on ArgumentError catch (e) {
    buffer.writeln('  $e');
  }
  buffer.writeln('');
  buffer.writeln(
    '============================================================',
  );
  buffer.writeln('');

  write(buffer.toString());
}
