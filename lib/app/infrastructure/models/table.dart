import 'package:excel_review/app/infrastructure/models/row.dart';
import 'package:excel_review/core/external/document.dart';
import 'package:excel_review/core/external/model.dart';

final class Table implements Model {
  final String _name;
  final Iterable<Row> _rows;

  const Table({
    required final String name,
    required final Iterable<Row> rows,
  })  : _rows = rows,
        _name = name;

  @override
  Format print<Format>(
    final Document<Format> printer,
  ) =>
      printer.prettify(
        {
          "name": _name,
          "rows": _rows
              .map(
                (row) => row.print(printer),
              )
              .toList(growable: false),
        },
      );
}
