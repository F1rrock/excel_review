import 'package:excel_review/app/domain/entities/table/cell.dart';
import 'package:test/test.dart';

void main() {
  group('cell test functionality', () {
    late Cell cell;
    setUp(() {
      cell = const Cell(name: 'name', value: 'value');
    });
    group('validate method testing', () {
      test('validate method passed', () {
        final actual = cell.validate('name');
        expect(actual, equals(true));
      });
      test('validate method rejected', () {
        final actual = cell.validate('other');
        expect(actual, equals(false));
      });
    });
    group('contains method testing', () {
      test('value really contains', () {
        final actual = cell.contains('val');
        expect(actual, equals(true));
      });
      test('value isn\t contains', () {
        final actual = cell.contains('other');
        expect(actual, equals(false));
      });
    });
    test('content getter testing', () {
      const expected = {
        'name': 'name',
        'value': 'value',
      };
      final actual = cell.content;
      expect(actual, equals(expected));
    });
  });
}