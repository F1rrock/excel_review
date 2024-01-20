import 'package:excel_review/app/domain/entities/table/cell.dart';
import 'package:excel_review/app/domain/entities/table/row.dart';
import 'package:excel_review/app/domain/entities/table/table.dart';
import 'package:excel_review/app/domain/entities/table/tables.dart';
import 'package:excel_review/core/external/document.dart';
import 'package:excel_review/core/external/filter.dart';
import 'package:excel_review/core/types/json.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

final class MockFilter extends Mock implements Filter<Row> {}

final class MockDocument implements Document<Json> {
  const MockDocument();

  @override
  Json prettify(final Json origin) => origin;
}

void main() {
  group('table test functionality', () {
    late Tables tables;
    late Document<Json> document;
    late Filter<Row> filter;
    setUp(() {
      registerFallbackValue(Row(index: 1, cells: []));
      tables = Tables(
        origin: [
          const Table(name: 'table', rows: [
            Row(index: 1, cells: [
              Cell(name: 'name', value: 'value'),
            ]),
            Row(index: 2, cells: [
              Cell(name: 'name', value: 'other'),
            ]),
          ])
        ],
      );
      document = const MockDocument();
      filter = MockFilter();
    });
    group('find method testing', () {
      test('find rows successfully', () {
        when(() => filter.accept(any())).thenReturn(true);
        final print = tables.find<Json>(filter);
        final actual = print(document, document);
        const expected = {
          'founded': [
            {
              'name': 'table',
              'founded': [
                {
                  'index': 1,
                  'cells': [
                    {
                      'name': 'name',
                      'value': 'value',
                    },
                  ],
                },
                {
                  'index': 2,
                  'cells': [
                    {
                      'name': 'name',
                      'value': 'other',
                    },
                  ],
                },
              ],
            },
          ],
        };
        expect(actual, equals(expected));
        verify(() => filter.accept(any())).called(1);
      });
      test('rows accepted by fliter aren\'t exists', () {
        when(() => filter.accept(any())).thenReturn(false);
        final print = tables.find<Json>(filter);
        final actual = print(document, document);
        final expected = {
          'founded': [],
        };
        expect(actual, equals(expected));
        verify(() => filter.accept(any())).called(1);
      });
    });
    group('fetch by name method testing', () {
      test(
        'successfully fetch',
        () {
          when(() => filter.accept(any())).thenReturn(true);
          final table = tables.fetchByName('table');
          final print = table.find<Json>(filter);
          final actual = print(document);
          const expected = {
            'founded': [
              {
                'index': 1,
                'cells': [
                  {
                    'name': 'name',
                    'value': 'value',
                  },
                ],
              },
              {
                'index': 2,
                'cells': [
                  {
                    'name': 'name',
                    'value': 'other',
                  },
                ],
              },
            ],
          };
          expect(actual, equals(expected));
          verify(() => filter.accept(any())).called(1);
        },
      );
      test('nothings found', () {
        when(() => filter.accept(any())).thenReturn(true);
        expect(
          () => tables.fetchByName('other'),
          throwsA(isA<StateError>()),
        );
        verifyNever(() => filter.accept(any()));
      });
    });
    group('fetch by index method testing', () {
      test(
        'successfully fetch',
        () {
          when(() => filter.accept(any())).thenReturn(true);
          final table = tables.fetchByIndex(1);
          final print = table.find<Json>(filter);
          final actual = print(document);
          const expected = {
            'founded': [
              {
                'index': 1,
                'cells': [
                  {
                    'name': 'name',
                    'value': 'value',
                  },
                ],
              },
              {
                'index': 2,
                'cells': [
                  {
                    'name': 'name',
                    'value': 'other',
                  },
                ],
              },
            ],
          };
          expect(actual, equals(expected));
          verify(() => filter.accept(any())).called(1);
        },
      );
      test('nothings found', () {
        when(() => filter.accept(any())).thenReturn(true);
        expect(
          () => tables.fetchByIndex(10),
          throwsA(isA<StateError>()),
        );
        verifyNever(() => filter.accept(any()));
      });
    });
  });
}
