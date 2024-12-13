import '../../model/post_model.dart';
import 'remote_posts_data.dart';

class FakeRemotePostData extends RemotePostData {

  final List<Post> _fakePosts = [
    Post(id: '3', title: 'Yassine', description: 'I want to make posts'),
  ];
  @override
  Future<List<Post>> getAllPost() async {

      await Future.delayed(const Duration(seconds: 1));
      return _fakePosts;
    }

  @override
  Future<Post> createPost(Post postToAdd) async {

    await Future.delayed(const Duration(seconds: 1));
    _fakePosts.add(postToAdd);
    return postToAdd;
  }

  @override
  Future<Post> updatePost(Post updatedPost) async {

    await Future.delayed(const Duration(seconds: 1));
    final index = _fakePosts.indexWhere((post) => post.id == updatedPost.id);

    if (index != -1) {
      _fakePosts[index] = updatedPost;
      return updatedPost;
    }
    throw Exception('Post not found');
  }
  }

