import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_flutter_el_matror_yassine/shared/post_list_bloc/post_list_bloc.dart';
import 'post_form_page.dart';
import '../widgets/post_card.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts List'),
      ),
      body: BlocBuilder<PostListBloc, PostListState>(
        builder: (context, state) {
          if (state.status == PostListStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == PostListStatus.success) {
            final posts = state.posts;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return PostCard(
                  title: post.title,
                  description: post.description,
                  onEdit: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostFormPage(
                          isEditing: true,
                          postId: post.id,
                          postTitle: post.title,
                          postDescription: post.description,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state.status == PostListStatus.error) {
            return Center(child: Text(state.exception?.message ?? 'Error occurred'));
          }
          return const Center(child: Text('No posts available'));
        },
      )
      ,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PostFormPage(isEditing: false),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
