import 'package:excel_review/core/external/document.dart';
import 'package:excel_review/core/external/model.dart';

final class Cell implements Model {
  final String _name;
  final String _value;

  const Cell({
    required final String name,
    required final String value,
  })  : _name = name,
        _value = value;

  @override
  Format print<Format>(
    final Document<Format> printer,
  ) =>
      printer.prettify(
        {
          "name": _name,
          "value": _value,
        },
      );
}
