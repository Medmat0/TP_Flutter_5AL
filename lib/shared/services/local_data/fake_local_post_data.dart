import 'local_post_data.dart';
import '../../model/post_model.dart';



class FakePostData extends LocalPostData {
  final List<Post> _fakePosts = [
    Post(id: '1', title: 'First post local', description: 'This is a fake first post local'),
    Post(id: '2', title: 'Second post local', description: 'This is a fake second post local '),
    Post(id: '3', title: 'EL MATROR', description: 'I want to make toast'),
  ];

  @override
  Future<Post> createPost(Post postToAdd) async {
    await Future.delayed(const Duration(seconds: 1));
    _fakePosts.add(postToAdd);
    return postToAdd;
  }

  @override
  Future<List<Post>> getAllPost() async {
    await Future.delayed(const Duration(seconds: 1));
    return _fakePosts;
  }


  @override
  Future<Post> updatePost(Post updatedPost) async {
    await Future.delayed(const Duration(seconds: 1));
    final index = _fakePosts.indexWhere((p) => p.id == updatedPost.id);
    if (index != -1) {
      _fakePosts[index] = updatedPost;
      return updatedPost;
    } else {
      throw Exception('Post not found');
    }
  }

  @override
  Future<void> save(List<Post> posts) async{
    return;
  }

}