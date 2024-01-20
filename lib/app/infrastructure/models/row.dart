import 'package:excel_review/app/infrastructure/models/cell.dart';
import 'package:excel_review/core/external/document.dart';
import 'package:excel_review/core/external/model.dart';

final class Row implements Model {
  final int _index;
  final Iterable<Cell> _cells;

  const Row({
    required final int index,
    required final Iterable<Cell> cells,
  })  : _index = index,
        _cells = cells;

  @override
  Format print<Format>(
    final Document<Format> printer,
  ) =>
      printer.prettify(
        {
          "index": _index,
          "cells": _cells
              .map(
                (cell) => cell.print(printer),
              )
              .toList(
                growable: false,
              ),
        },
      );
}
