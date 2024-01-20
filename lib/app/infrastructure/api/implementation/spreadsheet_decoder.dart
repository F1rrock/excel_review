import 'package:excel_review/app/infrastructure/api/excel_driver.dart';
import 'package:excel_review/app/infrastructure/models/cell.dart';
import 'package:excel_review/app/infrastructure/models/row.dart';
import 'package:excel_review/app/infrastructure/models/table.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart' as package;
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';

final class SpreadsheetDecoder implements ExcelDriver {
  const SpreadsheetDecoder();

  Iterable<Table> _map(final SpreadsheetTable table) sync* {
    final content = table.rows.map((row) => row.asMap());
    final rows = content.skip(1);
    final columns = content.first;
    var index = 0;
    yield Table(
      name: table.name,
      rows: rows.map(
        (row) => Row(
          index: ++ index,
          cells: row.entries.map(
            (entry) => Cell(
              name: columns[entry.key],
              value: entry.value.toString(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Future<Iterable<Table>> decode(final Iterable<int> bytes) async {
    final data = [...bytes];
    final decoder = package.SpreadsheetDecoder.decodeBytes(data);
    final tables = decoder.tables.values;
    return tables.expand(
      (table) sync* {
        yield* _map(table);
      },
    );
  }
}
