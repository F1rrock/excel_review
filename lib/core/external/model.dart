import 'package:excel_review/core/external/document.dart';

abstract class Model {
  Format print<Format>(final Document<Format> printer);
}