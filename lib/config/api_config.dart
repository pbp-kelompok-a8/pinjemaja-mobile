import 'package:flutter/foundation.dart' show kIsWeb;

class ApiConfig {
  // TODO: ganti dengan URL PWS setelah deploy,
  static const String _pwsUrl = '';

  static String get baseUrl {
    if (_pwsUrl.isNotEmpty) return _pwsUrl;
    return kIsWeb ? 'http://localhost:8000' : 'http://10.0.2.2:8000';
  }
}