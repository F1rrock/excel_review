import 'package:excel_review/app/domain/entities/file/file.dart';
import 'package:excel_review/app/domain/entities/table/tables.dart';
import 'package:excel_review/app/domain/gateways/table_file.dart';
import 'package:excel_review/app/domain/use_cases/read_file.dart';
import 'package:excel_review/core/errors/decoding_error.dart';
import 'package:excel_review/core/external/use_case.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

final class MockTableFile extends Mock implements TableFile {}

void main() {
  group('test tead file case functionality', () {
    late UseCase<Future<Tables>, File> readFile;
    late TableFile tableFile;
    late Tables tables;
    late File file;
    setUp(() {
      tables = Tables(origin: []);
      file = File(chuncks: []);
      tableFile = MockTableFile();
      readFile = ReadFile(tableFile: tableFile);
    });
    test(
      'received tables successfully',
      () async {
        when(() => tableFile.read(file)).thenAnswer((_) async => tables);
        final actual = await readFile(file);
        expect(actual, equals(tables));
        verify(() => tableFile.read(file)).called(1);
      },
    );
    test(
      'received tables error',
      () async {
        when(() => tableFile.read(file))
            .thenAnswer((_) async => throw const DecodingError());
        expect(
          () async => await readFile(file),
          throwsA(
            isA<DecodingError>(),
          ),
        );
        verify(() => tableFile.read(file)).called(1);
      },
    );
  });
}
