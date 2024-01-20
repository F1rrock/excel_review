import 'package:excel_review/app/external/docs/json_doc.dart';
import 'package:excel_review/core/external/document.dart';
import 'package:excel_review/core/types/json.dart';
import 'package:test/test.dart';

void main() {
  group('test json doc functionality', () {
    late Document<Json> jsonDoc;
    setUp(() {
      jsonDoc = JsonDoc();
    });
    test('successfully converts', () {
      const testable = {
        'name': 'name',
        'value': 'value',
      };
      final actual = jsonDoc.prettify(testable);
      expect(actual, equals(testable));
    });
  });
}