import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_flutter_el_matror_yassine/shared/post_list_bloc/post_list_bloc.dart';
import 'package:tp_flutter_el_matror_yassine/shared/post_form_bloc/post_form_bloc.dart';
import 'package:tp_flutter_el_matror_yassine/shared/services/local_data/fake_local_post_data.dart';
import 'package:tp_flutter_el_matror_yassine/shared/services/post_repository.dart';
import 'package:tp_flutter_el_matror_yassine/shared/services/local_data/local_post_data.dart';
import 'package:tp_flutter_el_matror_yassine/shared/services/remote_data/fake_remote_posts_data.dart';
import 'package:tp_flutter_el_matror_yassine/shared/services/remote_data/remote_posts_data.dart';
import 'package:tp_flutter_el_matror_yassine/pages/posts_page.dart';
import 'package:tp_flutter_el_matror_yassine/pages/post_form_page.dart';

void main() {
  // Initialize the PostRepository with both local and remote data sources
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PostRepository(
        localPostData: FakePostData(),  // Local data source
        remotePostData: FakeRemotePostData(),  // Remote data source
      ),
      child: MultiBlocProvider(
        providers: [
          // Providing PostFormBloc with the PostRepository
          BlocProvider(
            create: (context) => PostFormBloc(
              postRepository: context.read<PostRepository>(),
            ),
          ),
          // Providing PostListBloc with the PostRepository and loading posts
          BlocProvider(
            create: (context) => PostListBloc(postRepository: context.read<PostRepository>())
              ..add(LoadPostsEvent()),  // Loading posts when the app starts
          ),
        ],
        child: MaterialApp(
          title: 'Posts App',
          theme: ThemeData(primarySwatch: Colors.blue),
          initialRoute: '/',  // Setting the initial route to the posts page
          routes: {
            '/': (context) => const PostsPage(),  // Main page
            '/postForm': (context) => const PostFormPage(isEditing: false),  // Form page for creating posts
          },
        ),
      ),
    );
  }
}
