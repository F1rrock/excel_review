import 'package:excel_review/app/domain/entities/table/cell.dart';
import 'package:excel_review/app/domain/entities/table/simple_filter.dart';
import 'package:excel_review/app/domain/entities/table/row.dart';
import 'package:excel_review/app/domain/entities/table/table.dart';
import 'package:excel_review/core/external/document.dart';
import 'package:excel_review/core/external/filter.dart';
import 'package:excel_review/core/types/json.dart';
import 'package:test/test.dart';

final class MockDocument implements Document<Json> {
  const MockDocument();

  @override
  Json prettify(final Json origin) => origin;
}

void main() {
  group('table test functionality', () {
    late Table table;
    late Document<Json> document;
    setUp(() {
      table = const Table(name: 'table', rows: [
        Row(index: 1, cells: [
          Cell(name: 'name', value: 'value'),
        ]),
        Row(index: 2, cells: [
          Cell(name: 'name', value: 'other'),
        ]),
      ]);
      document = const MockDocument();
    });
    group('find method testing', () {
      test('find rows successfully', () {
        final Filter<Row> filter = SimpleFilter(requirements: [
          (column: 'name', comparable: 'value'),
        ]);
        final print = table.find<Json>(filter);
        final actual = print(document);
        final expected = {
          'founded': [
            {
              'index': 1,
              'cells': [
                {
                  'name': 'name',
                  'value': 'value',
                },
              ],
            }
          ],
        };
        expect(actual, equals(expected));
      });
      test('rows accepted by fliter aren\'t exists', () {
        final Filter<Row> filter = SimpleFilter(requirements: [
          (column: 'other', comparable: 'value'),
        ]);
        final print = table.find<Json>(filter);
        final actual = print(document);
        final expected = {
          'founded': [],
        };
        expect(actual, equals(expected));
      });
    });
    test('name getter testing', () {
      const expected = 'table';
      final actual = table.name;
      expect(actual, equals(expected));
    });
  });
}
