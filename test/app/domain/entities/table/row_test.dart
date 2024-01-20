import 'package:excel_review/app/domain/entities/table/cell.dart';
import 'package:excel_review/app/domain/entities/table/row.dart';
import 'package:test/test.dart';

void main() {
  group('row test functionality', () {
    late Row row;
    setUp(() {
      row = const Row(index: 1, cells: [
        Cell(name: 'name', value: 'value'),
        Cell(name: 'name1', value: 'value1'),
      ]);
    });
    group('fits method testing', () {
      test('row really fits', () {
        final actual = row.fits('name', 'val');
        expect(actual, equals(true));
      });
      test('row isn\t fits', () {
        final actual = row.fits('name', 'other');
        expect(actual, equals(false));
      });
    });
    test('content getter testing', () {
      const expected = {
        'index': 1,
        'cells': [
          {
            'name': 'name',
            'value': 'value',
          },
          {
            'name': 'name1',
            'value': 'value1',
          },
        ],
      };
      final actual = row.content;
      expect(actual, equals(expected));
    });
  });
}