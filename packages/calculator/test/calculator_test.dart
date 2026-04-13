import 'package:calculator/calculator.dart';
import 'package:test/test.dart';

void main() {
  final Calculator calculator = const BasicCalculator();

  test('add', () {
    expect(calculator.add(2, 3), 5);
    expect(calculator.add(-1.5, 1.5), 0);
  });

  test('subtract', () {
    expect(calculator.subtract(10, 4), 6);
    expect(calculator.subtract(0, 5), -5);
  });

  test('multiply', () {
    expect(calculator.multiply(3, 4), 12);
    expect(calculator.multiply(-2, 3), -6);
  });

  test('divide', () {
    expect(calculator.divide(10, 2), 5);
    expect(calculator.divide(1, 4), 0.25);
  });

  test('divide por cero lanza ArgumentError', () {
    expect(() => calculator.divide(1, 0), throwsArgumentError);
  });
}
