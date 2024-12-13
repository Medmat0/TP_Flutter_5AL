import '../../model/post_model.dart';

abstract class RemotePostData{

    Future<List<Post>> getAllPost();
    Future<Post> createPost(Post postToAdd);
    Future<Post> updatePost(Post updatedPost);

}
