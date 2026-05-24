/// Extension on [Stream] that provides additional stream transformations.
///
/// This extension adds utility methods for working with streams, such as
/// tracking previous values alongside current values.
extension StreamX<T> on Stream<T> {
  /// Returns a stream that emits the previous and current values of the source stream.
  ///
  /// The first emission will have `null` as the previous value, and subsequent
  /// emissions will include the previous value from the source stream.
  Stream<(T?, T)> preview() {
    T? previous;
    return map(
      (event) {
        final result = (previous, event);
        previous = event;
        return result;
      },
    );
  }
}
