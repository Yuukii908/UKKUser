class AppConfig {
  /// API base URL. Defaults to Android emulator localhost (10.0.2.2).
  /// For physical device, set via --dart-define API_BASE_URL=http://YOUR_PC_IP:8000
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:8000',
  );
}
