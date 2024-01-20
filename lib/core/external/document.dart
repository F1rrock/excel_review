import 'package:excel_review/core/types/json.dart';

abstract class Document<Format> {
  Format prettify(final Json origin);
}