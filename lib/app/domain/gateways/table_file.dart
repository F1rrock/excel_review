import 'package:excel_review/app/domain/entities/file/file.dart';
import 'package:excel_review/app/domain/entities/table/tables.dart';

abstract class TableFile {
  Future<Tables> read(final File file);
}