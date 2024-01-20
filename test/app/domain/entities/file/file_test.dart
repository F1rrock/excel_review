import 'dart:io' as io;
import 'dart:typed_data';

import 'package:excel_review/app/domain/entities/file/file.dart';
import 'package:excel_review/app/domain/entities/file/file_chunck.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

final class MockIOFile extends Mock implements io.File {}

void main() {
  group('file entity testing functionality', () {
    late File file;
    late io.File ioFile;
    late FileChunck chunck1;
    late FileChunck chunck2;
    setUp(() {
      chunck1 = FileChunck(bytes: [1, 2, 3, 4]);
      chunck2 = FileChunck(bytes: [5, 6, 7, 8]);
      file = File(chuncks: [chunck1, chunck2]);
      ioFile = MockIOFile();
    });
    test(
      'file content returns chuncks on content called',
      () {
        final chuncks = file.content;
        expect(chuncks, equals([chunck1, chunck2]));
      },
    );
    test(
      'file content returns chuncks on content called',
      () {
        final chuncks = file.content;
        expect(chuncks, equals([chunck1, chunck2]));
      },
    );
    test(
      'what if file content returns not incapsualted chuncks on content called',
      () {
        final chuncks = file.content;
        expect(chuncks, isNot(equals([chunck1])));
      },
    );
    test(
      'test io constructor for file entity',
      () {
        when(() => ioFile.readAsBytesSync()).thenReturn(
          Uint8List.fromList(
            [
              ...chunck1.content,
              ...chunck2.content,
            ],
          ),
        );
        final testable = File.io(origin: ioFile);
        final actual = file.content.expand((chunck) => chunck.content);
        final expected = testable.content.expand((chunck) => chunck.content);
        expect(actual, equals(expected));
        verify(() => ioFile.readAsBytesSync()).called(1);
      },
    );
  });
}
