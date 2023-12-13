import 'package:riverpodstructure/repositories/post_repo.dart';
import 'package:riverpodstructure/services/http_service.dart';
import 'package:riverpodstructure/states/api_states/api_state.dart';

class PostRepositoryImpl implements PostRepository {
  PostRepositoryImpl(this.httpService);
  late final HttpService httpService;


  @override
  Future<ApiState> getPost() async {
    final response = await httpService.get("posts");
    return response;
  }
}
