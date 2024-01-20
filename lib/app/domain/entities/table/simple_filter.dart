import 'package:excel_review/app/domain/entities/table/row.dart';
import 'package:excel_review/core/external/filter.dart';

final class SimpleFilter implements Filter<Row> {
  final List<({String column, String comparable})> _requirements;

  const SimpleFilter({
    required final List<({String column, String comparable})> requirements,
  }) : _requirements = requirements;

  @override
  bool accept(final Row row) {
    var success = true;
    for (final requirement in _requirements) {
      if (!row.fits(requirement.column, requirement.comparable)) {
        success = false;
      }
    }
    return success;
  }
}
