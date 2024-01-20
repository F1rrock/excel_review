import 'package:excel_review/app/domain/entities/table/row.dart';
import 'package:excel_review/app/domain/entities/table/table.dart';
import 'package:excel_review/core/external/document.dart';
import 'package:excel_review/core/external/filter.dart';
import 'package:excel_review/core/types/json.dart';

final class Tables {
  final Iterable<Table> _origin;

  const Tables({
    required final Iterable<Table> origin,
  }) : _origin = origin;

  Table fetchByName(final String name) => _origin.firstWhere(
        (table) => table.name == name,
      );

  Table fetchByIndex(final int index) => _origin.skip(index - 1).first;

  Format Function(Document<Format>, Document<Json>) find<Format>(
    final Filter<Row> filter,
  ) =>
      (final Document<Format> printer, final Document<Json> decoder) =>
          printer.prettify(
            {
              "founded": _origin
                  .map(
                    (table) {
                      final printBy = table.find<Json>(filter);
                      return {...printBy(decoder)}
                        ..addEntries([MapEntry("name", table.name)]);
                    },
                  )
                  .where((response) => response['founded'].isNotEmpty)
                  .toList(growable: false),
            },
          );
}
