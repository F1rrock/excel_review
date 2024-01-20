// import 'package:excel_review/app/domain/entities/file/file.dart';
// import 'package:excel_review/app/domain/entities/file/file_chunck.dart';
// import 'package:excel_review/app/domain/gateways/table_file.dart';
import 'package:excel_review/app/infrastructure/api/excel_driver.dart';
// import 'package:excel_review/app/infrastructure/gateways/excel.dart';
import 'package:excel_review/app/infrastructure/models/cell.dart';
import 'package:excel_review/app/infrastructure/models/row.dart';
import 'package:excel_review/app/infrastructure/models/table.dart';
import 'package:excel_review/core/external/document.dart';
import 'package:excel_review/core/types/json.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

final class MockDriver extends Mock implements ExcelDriver {}

final class MockDocument implements Document<Json> {
  const MockDocument();

  @override
  Json prettify(final Json origin) => origin;
}

void main() {
  group('test excel gateway functionality', () {
    // late TableFile tableFile;
    late ExcelDriver driver;
    // late Document<Json> document;
    // late File file;
    setUp(() {
      driver = MockDriver();
      // document = MockDocument();
      /* tableFile = Excel(
        driver: driver,
        jsonDoc: document,
      );
      file = File(chuncks: [
        FileChunck(bytes: [1, 2, 3, 4]),
      ]);*/
    });
    test(
      'successfully read file',
      () async {
        when(() => driver.decode(any())).thenAnswer((_) async => [
            Table(name: 'table', rows: [
              Row(index: 1, cells: [
                Cell(name: 'name', value: 'value'),
                Cell(name: 'name', value: 'other'),
              ]),
            ]),
          ],
        );
        
      },
    );
  });
}
