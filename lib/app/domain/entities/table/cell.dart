import 'package:excel_review/core/types/json.dart';

final class Cell {
  final String _name;
  final String _value;

  const Cell({
    required final String name,
    required final String value,
  })  : _name = name,
        _value = value;

  bool validate(final String name) => _name == name;

  bool contains(final String comparable) => _value.contains(comparable);

  Json get content => {
        "name": _name,
        "value": _value,
      };
}
