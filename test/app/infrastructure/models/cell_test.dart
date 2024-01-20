import 'package:excel_review/app/infrastructure/models/cell.dart';
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
    'test cell model functionality',
    () {
      late Cell cell;
      late Document<Json> document;
      setUp(() {
        cell = Cell(
          name: 'name',
          value: 'value',
        );
        document = MockDocument();
      });
      test(
        'print method tesing',
        () {
          const expected = {
            'name': 'name',
            'value': 'value',
          };  
          final actual = cell.print<Json>(document);
          expect(actual, equals(expected));
        },
      );
    },
  );
}
