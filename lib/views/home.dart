import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodstructure/models/post.dart';
import 'package:riverpodstructure/providers/post_notifier.dart';
import 'package:riverpodstructure/repositories/post_repo.dart';
import 'package:riverpodstructure/states/api_states/api_state.dart';

final postProvider = StateNotifierProvider.autoDispose<PostProvider, ApiState>((ref) {
  final postRepo = ref.read(postRepositoryProvider);

  return PostProvider(postRepo);
});

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      body: Consumer(
        builder: (context, ref, child) {
          final postData = ref.watch(postProvider);
          print("State>>>>>>>>>>>>>. is : ${postData}");
          if (postData is LoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (postData is SuccessState) {
            final List<dynamic> apiPostData = postData.data;
            final List<PostModel> allPostList = apiPostData.map((data) => PostModel.fromJson(data)).toList();
            return ListView.builder(
              itemCount: allPostList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(allPostList[index].id.toString()),
                  subtitle: Text(allPostList[index].title.toString()),
                );
              },
            );
          } else if (postData is ErrorState) {
            return Center(
              child: Text("Error"),
            );
          } else {
            return Center(
              child: Text("Others"),
            );
          }
        },
      ),
    );
  }
}
