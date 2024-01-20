import 'dart:io' as io;

import 'package:excel_review/app/domain/entities/file/file_chunck.dart';

final class File {
  final Iterable<FileChunck> _chuncks;

  const File({
    required final Iterable<FileChunck> chuncks,
  }) : _chuncks = chuncks;

  factory File.io({
    required final io.File origin,
  }) {
    final bytes = origin.readAsBytesSync();
    final chunck = FileChunck(bytes: bytes);
    return File(chuncks: [chunck]);
  }

  Iterable<FileChunck> get content sync* {
    yield* _chuncks;
  }
}