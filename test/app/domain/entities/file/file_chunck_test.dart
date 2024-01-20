import 'package:excel_review/app/domain/entities/file/file_chunck.dart';
import 'package:test/test.dart';

void main() {
  group('file chunck test fucntionality', () {
    late FileChunck chunck;
    late Iterable<int> bytes;
    setUp(() {
      bytes = [1, 2, 3, 4];
      chunck = FileChunck(bytes: bytes);
    });
    test(
      'chunck response on content called the incapsulated bytes',
      () {
        final actual = chunck.content;
        expect(actual, equals(bytes));
      },
    );
    test(
      'what if chunck response on content called not the incapsulated bytes',
      () {
        final actual = chunck.content;
        expect(actual, isNot(equals([0, 0])));
      },
    );
  });
}
