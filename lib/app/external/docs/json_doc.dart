import 'package:excel_review/core/external/document.dart';
import 'package:excel_review/core/types/json.dart';

final class JsonDoc implements Document<Json> {
  const JsonDoc();

  @override
  Json prettify(final Json origin) => origin;
}