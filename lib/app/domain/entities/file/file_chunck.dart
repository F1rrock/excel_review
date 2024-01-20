final class FileChunck {
  final Iterable<int> _bytes;

  const FileChunck({
    required final Iterable<int> bytes,
  }) : _bytes = bytes;

  Iterable<int> get content => _bytes;
}