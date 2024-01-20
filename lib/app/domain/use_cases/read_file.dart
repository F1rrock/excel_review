import 'package:excel_review/app/domain/entities/file/file.dart';
import 'package:excel_review/app/domain/entities/table/tables.dart';
import 'package:excel_review/app/domain/gateways/table_file.dart';
import 'package:excel_review/core/external/use_case.dart';

final class ReadFile implements UseCase<Future<Tables>, File> {
  final TableFile _tableFile;

  const ReadFile({
    required final TableFile tableFile,
  }) : _tableFile = tableFile;

  @override
  Future<Tables> call(final File param) async => await _tableFile.read(param);
}