import 'package:excel_review/app/infrastructure/models/cell.dart';
import 'package:excel_review/app/infrastructure/models/row.dart';
import 'package:excel_review/app/infrastructure/models/table.dart';
import 'package:excel_review/core/external/document.dart';
import 'package:excel_review/core/types/json.dart';
import 'package:test/test.dart';

final class MockDocument implements Document<Json> {
  const MockDocument();

  @override
  Json prettify(final Json origin) => origin;
}

void main() {
  group(
    'test table model functionality',
    () {
      late Table table;
      late Document<Json> document;
      setUp(() {
        document = MockDocument();
        table = Table(name: 'table', rows: [
          Row(index: 1, cells: [
            Cell(name: 'name', value: 'value'),
            Cell(name: 'name', value: 'other'),
          ]),
        ]);
      });
      test(
        'print method testing',
        () {
          final actual = table.print<Json>(document);
          const expected = {
            'name': 'table',
            'rows': [
              {
                'index': 1,
                'cells': [
                  {
                    'name': 'name',
                    'value': 'value',
                  },
                  {
                    'name': 'name',
                    'value': 'other',
                  },
                ],
              },
            ],
          };
          expect(actual, equals(expected));
        },
      );
    },
  );
}
