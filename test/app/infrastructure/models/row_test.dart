import 'package:excel_review/app/infrastructure/models/cell.dart';
import 'package:excel_review/app/infrastructure/models/row.dart';
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
    'test row model functionality',
    () {
      late Row row;
      late Document<Json> document;
      setUp(() {
        document = MockDocument();
        row = Row(index: 1, cells: [
          Cell(
            name: 'name',
            value: 'value',
          ),
          Cell(
            name: 'name',
            value: 'other',
          ),
        ]);
      });
      test(
        'print method testing',
        () {
          final actual = row.print<Json>(document);
          const expected = {
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
          };
          expect(actual, equals(expected));
        },
      );
    },
  );
}
