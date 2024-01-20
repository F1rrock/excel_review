import 'package:excel_review/app/infrastructure/models/table.dart';

abstract class ExcelDriver {
  Future<Iterable<Table>> decode(final Iterable<int> bytes);
}