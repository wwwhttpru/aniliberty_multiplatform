abstract interface class IKeyValueDB<T extends Object> {
  /// Create or update the value
  Future<void> createOrUpdate(T value);

  /// Read the value
  Future<T?> read();

  /// Delete the value
  Future<void> delete();
}
