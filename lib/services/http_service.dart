abstract class HttpService {
  /// Http base url
  String get baseUrl;

  /// Http headers
  Map<String, String> get headers;

  /// Http get request
  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    bool forceRefresh = false,
  });

  /// Http post request
  Future<dynamic> post(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Object? body,
  });
}
