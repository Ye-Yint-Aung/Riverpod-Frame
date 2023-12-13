import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodstructure/repositories/post_repo.dart';
import 'package:riverpodstructure/states/api_states/api_state.dart';

class PostProvider extends StateNotifier<ApiState> {
  PostProvider(PostRepository postRepo)
      : postRepository = postRepo,
        super(InitialState()) {
    getAllPost();
  }

  late final PostRepository postRepository;

  void getAllPost() async {
    state = LoadingState();
    final response = await postRepository.getPost();
    print("All User in UserProvider $response");
    state = response;
  }
}
