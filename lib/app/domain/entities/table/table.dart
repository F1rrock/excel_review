import 'package:excel_review/app/domain/entities/table/row.dart';
import 'package:excel_review/core/external/document.dart';
import 'package:excel_review/core/external/filter.dart';

final class Table {
  final String _name;
  final Iterable<Row> _rows;

  const Table({
    required final String name,
    required final Iterable<Row> rows,
  })  : _rows = rows,
        _name = name;

  String get name => _name;

  Format Function(Document<Format>) find<Format>(
    final Filter<Row> filter,
  ) =>
      (final Document<Format> printer) => printer.prettify(
            {
              "founded": _rows
                  .where(
                    (row) => filter.accept(row),
                  )
                  .map(
                    (row) => row.content,
                  )
                  .toList(growable: false),
            },
          );
}
