import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodstructure/services/dio_http_service.dart';
import 'package:riverpodstructure/services/http_service.dart';

final httpServiceProvider = Provider<HttpService>((ref) {
  return DioHttpService();
});