import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_flutter_el_matror_yassine/shared/model/post_model.dart';
import 'package:tp_flutter_el_matror_yassine/shared/post_form_bloc/post_form_bloc.dart';
import 'package:tp_flutter_el_matror_yassine/shared/post_list_bloc/post_list_bloc.dart' as list;

class PostFormPage extends StatelessWidget {
  final bool isEditing;
  final String? postId;
  final String? postTitle;
  final String? postDescription;

  const PostFormPage({
    Key? key,
    required this.isEditing,
    this.postId,
    this.postTitle,
    this.postDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: postTitle);
    final descriptionController = TextEditingController(text: postDescription);

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Post' : 'Create Post'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                hintText: 'Enter the post title',
                prefixIcon: Icon(Icons.title),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                hintText: 'Enter the post description',
                prefixIcon: Icon(Icons.description),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                ),
              ),
              maxLines: 5,
            ),
            const Spacer(),
            BlocListener<PostFormBloc, PostFormState>(
              listener: (context, state) {
                if (state.status == PostFormStatus.success) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Success'),
                      content: Text(isEditing
                          ? 'Post updated successfully!'
                          : 'Post created successfully!'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            context.read<list.PostListBloc>().add(list.LoadPostsEvent());
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                } else if (state.status == PostFormStatus.error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.exception?.message ?? 'An error occurred')),
                  );
                }
              },
              child: BlocBuilder<PostFormBloc, PostFormState>(
                builder: (context, state) {
                  if (state.status == PostFormStatus.submitting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ElevatedButton(
                    onPressed: () {
                      final postTitle = titleController.text;
                      final postDescription = descriptionController.text;
                      if (postTitle.isEmpty || postDescription.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Both title and description are required!')),
                        );
                        return;
                      }
                      if (isEditing) {
                        context.read<PostFormBloc>().add(
                          UpdatePostEvent(
                            updatedPost: Post(
                              id: postId ?? '1',
                              title: postTitle,
                              description: postDescription,
                            ),
                          ),
                        );
                      } else {
                        final newPostId = getNextPostId();
                        context.read<PostFormBloc>().add(
                          CreatePostEvent(
                            newPost: Post(
                              id: newPostId,
                              title: postTitle,
                              description: postDescription,
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(isEditing ? 'Update Post' : 'Create Post'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getNextPostId() {
    int currentMaxId = 3 ;  //parceque j'ai deja 3 posts dans fake data
    return (currentMaxId + 1).toString();
  }
}
 