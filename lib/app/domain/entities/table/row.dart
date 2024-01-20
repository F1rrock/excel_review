import 'package:excel_review/app/domain/entities/table/cell.dart';
import 'package:excel_review/core/types/json.dart';

final class Row {
  final int _index;
  final Iterable<Cell> _cells;

  const Row({
    required final int index,
    required final Iterable<Cell> cells,
  })  : _index = index,
        _cells = cells;

  bool fits(final String column, final String comparable) => _cells
      .where(
        (cell) => cell.validate(column) && cell.contains(comparable),
      )
      .isNotEmpty;

  Json get content => {
        "index": _index,
        "cells": _cells
            .map(
              (cell) => cell.content,
            )
            .toList(growable: false),
      };
}
