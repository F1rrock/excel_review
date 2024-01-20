# Excel review

## Description

This module provides API, to filter and find data in excel files

## Usage

first, you have to opt the bus, which provides API with reuired functionality: 
```dart
final Bus<UseCase<Future<Tables>, File>> appBus = ExcelReview();
```

Then, you have to achive use case, that provides you by bus
```dart
final UseCase<Future<Tables>, File> readFile = appBus.config();
```

then you have to declare File entity, for example by io constructor and pass it to configured use case
```dart
import 'dart:io' as io;
import 'package:excel_review/excel_review.dart';

Future<void> main() async {
    final file = File.io(origin: io.File('path here'));
    final tables = await readFile(file);
}
```

then you can achive reuired table, or find data in the hole tables in the file
```dart
final table = tables.fetchByIndex(1);
final table = tables.fetchByName('Sheet1');

final Filter<Row> filter = FilterImplementation();
final Document<Xml> docuemnt = XmlDoc();
final Document<Json> decoder = JsonDoc();
final print = tables.find<Xml>(filter);
final xmlData = print(docuemnt, decoder);
...
```

`use cases` can throw an `DecodingError` exception, which you have to handle every time, that you try to call it.