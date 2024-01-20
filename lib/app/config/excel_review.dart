import 'package:excel_review/app/domain/entities/file/file.dart';
import 'package:excel_review/app/domain/entities/table/tables.dart';
import 'package:excel_review/app/domain/gateways/table_file.dart';
import 'package:excel_review/app/domain/use_cases/read_file.dart';
import 'package:excel_review/app/external/docs/json_doc.dart';
import 'package:excel_review/app/infrastructure/api/excel_driver.dart';
import 'package:excel_review/app/infrastructure/api/implementation/spreadsheet_decoder.dart';
import 'package:excel_review/app/infrastructure/gateways/excel.dart';
import 'package:excel_review/core/external/bus.dart';
import 'package:excel_review/core/external/document.dart';
import 'package:excel_review/core/external/use_case.dart';
import 'package:excel_review/core/types/json.dart';

final class ExcelReview implements Bus<UseCase<Future<Tables>, File>> {
  const ExcelReview();

  @override
  UseCase<Future<Tables>, File> config() {
    const ExcelDriver driver = SpreadsheetDecoder();
    const Document<Json> doc = JsonDoc();
    const TableFile excel = Excel(
      driver: driver,
      jsonDoc: doc,
    );
    return ReadFile(tableFile: excel);
  }
}
