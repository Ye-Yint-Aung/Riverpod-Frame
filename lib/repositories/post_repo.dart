import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodstructure/repositories/post_repo_impl.dart';
import 'package:riverpodstructure/services/http_service_provider.dart';
import 'package:riverpodstructure/states/api_states/api_state.dart';

final postRepositoryProvider = Provider<PostRepository>((ref) {
  final httpService = ref.watch(httpServiceProvider);
  return PostRepositoryImpl(httpService);
});

abstract class PostRepository {
  Future<ApiState> getPost();
}
