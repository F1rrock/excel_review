import 'dart:io';

import 'package:excel_review/app/infrastructure/api/excel_driver.dart';
import 'package:excel_review/app/infrastructure/api/implementation/spreadsheet_decoder.dart';
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
    'test spreadsheet decoder functionality',
    () {
      late ExcelDriver driver;
      late File file;
      late Document<Json> document;
      setUp(() {
        driver = SpreadsheetDecoder();
        file = File('test/fixtures/file.xlsx');
        document = MockDocument();
      });
      test(
        'decode method testing',
        () async {
          final bytes = file.readAsBytesSync();
          final tables = await driver.decode(bytes);
          final actual = tables.map((table) => table.print<Json>(document));
          const expected = [
            {
              'name': 'Sheet1',
              'rows': [
                {
                  'index': 1,
                  'cells': [
                    {
                      'name': 'name',
                      'value': 'value',
                    },
                  ],
                },
              ],
            },
          ];
          expect(actual, equals(expected));
        },
      );
    },
  );
}
