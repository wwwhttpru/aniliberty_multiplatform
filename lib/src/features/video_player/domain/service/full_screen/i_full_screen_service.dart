/// Interface for working with fullscreen mode
abstract interface class IFullScreenService {
  /// Whether fullscreen mode is supported on the current platform
  bool get isFullscreenSupported;

  /// Whether the application is in fullscreen mode
  bool get isFullscreen;

  /// Stream of fullscreen support changes
  Stream<bool> get fullscreenSupportedStream;

  /// Stream of fullscreen state changes
  Stream<bool> get fullscreenStream;

  /// Initialize the service (create subscriptions, etc.)
  Future<void> init();

  /// Clean up resources (remove subscriptions, etc.)
  Future<void> dispose();

  /// Toggle fullscreen mode
  Future<void> toggleFullscreen();

  /// Enter fullscreen mode
  Future<void> enterFullscreen();

  /// Exit fullscreen mode
  Future<void> exitFullscreen();
}
