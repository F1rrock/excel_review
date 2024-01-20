import 'package:excel_review/app/domain/entities/file/file.dart';
import 'package:excel_review/app/domain/entities/table/cell.dart';
import 'package:excel_review/app/domain/entities/table/row.dart';
import 'package:excel_review/app/domain/entities/table/table.dart';
import 'package:excel_review/app/domain/entities/table/tables.dart';
import 'package:excel_review/app/domain/gateways/table_file.dart';
import 'package:excel_review/app/infrastructure/api/excel_driver.dart';
import 'package:excel_review/core/errors/decoding_error.dart';
import 'package:excel_review/core/external/document.dart';
import 'package:excel_review/core/types/json.dart';

final class Excel implements TableFile {
  final ExcelDriver _driver;
  final Document<Json> _jsonDoc;

  const Excel({
    required final ExcelDriver driver,
    required final Document<Json> jsonDoc,
  })  : _driver = driver,
        _jsonDoc = jsonDoc;

  Iterable<Table> _map(final Iterable<Json> decoded) sync* {
    yield* decoded.map(
      (tableModel) => Table(
        name: tableModel['name'],
        rows: [...tableModel['rows']].map(
          (rowModel) => Row(
            index: rowModel['index'] ?? 0,
            cells: [...rowModel['cells']].map(
              (cellModel) => Cell(
                name: cellModel['name'],
                value: cellModel['value'],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Future<Tables> read(final File file) async {
    final bytes = file.content.expand((chunck) => chunck.content);
    try {
      final models = await _driver.decode(bytes);
      final tableModels = models.map((model) => model.print(_jsonDoc));
      return Tables(
        origin: _map(tableModels),
      );
    } catch (_) {
      throw const DecodingError();
    }
  }
}
