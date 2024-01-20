import 'package:excel_review/core/external/filter.dart';

final class All<Param> implements Filter<Param> {
  const All();
  
  @override
  bool accept(final Param param) => true;
}