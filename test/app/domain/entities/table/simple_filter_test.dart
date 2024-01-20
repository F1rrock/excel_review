import 'package:excel_review/app/domain/entities/table/cell.dart';
import 'package:excel_review/app/domain/entities/table/row.dart';
import 'package:excel_review/app/domain/entities/table/simple_filter.dart';
import 'package:excel_review/core/external/filter.dart';
import 'package:test/test.dart';

void main() {
  group('test simple filter functionality', () {
    late Filter<Row> filter;
    setUp(() {
      filter = SimpleFilter(requirements: [
        (column: 'name', comparable: 'value'),
      ]);
    });
    test('successfully accept', () {
      const row = Row(index: 1, cells: [
        Cell(name: 'name', value: 'value'),
      ]);
      final actual = filter.accept(row);
      expect(actual, equals(true));
    });
    test('rejected', () {
      const row = Row(index: 1, cells: [
        Cell(name: 'name1', value: 'value'),
      ]);
      final actual = filter.accept(row);
      expect(actual, equals(false));
    });
  });
}