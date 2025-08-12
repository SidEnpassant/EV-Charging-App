class AppConstants {
  // App Info
  static const String appName = 'Chargerrr';
  static const String appTagline = 'Charge Anywhere. Drive Everywhere.';
  static const String appVersion = '1.0.0';

  // Supabase Collections
  static const String chargingStationsCollection = 'charging_stations';
  static const String usersCollection = 'users';

  // Map Constants
  static const double defaultZoom = 14.0;
  static const double defaultLatitude = 28.6139; // New Delhi
  static const double defaultLongitude = 77.2090; // New Delhi

  // Animations
  static const String loadingAnimation = 'assets/animations/loading.json';
  static const String emptyAnimation = 'assets/animations/empty.json';
  static const String errorAnimation = 'assets/animations/error.json';

  // Storage Keys
  static const String themeKey = 'app_theme';
  static const String userTokenKey = 'user_token';
  static const String userDataKey = 'user_data';

  // Timeouts
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
}
