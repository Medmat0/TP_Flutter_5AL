import '../model/post_model.dart';
import './remote_data/remote_posts_data.dart';
import './local_data/local_post_data.dart';

class PostRepository
{
     final RemotePostData remotePostData;
     final LocalPostData localPostData;


     const PostRepository({
       required this.localPostData,
       required this.remotePostData,
     });

     Future<List<Post>> getAllPost() {
          try
          {
            final posts = remotePostData.getAllPost();
            localPostData.save(posts as List<Post>);
            return posts;
          } catch(error) {
            return localPostData.getAllPost();
          }

     }

     Future<Post> createPost(Post post) async {
       try {
         final createdPost = await remotePostData.createPost(post);
         await localPostData.createPost(createdPost);
         return createdPost;
       } catch (error) {
         throw Exception('Error creating post remotely');
       }
     }

     Future<Post> updatePost(Post updatedPost) async {
       try {
         final post = await remotePostData.updatePost(updatedPost);
         await localPostData.updatePost(post);
         return post;
       } catch (error) {
         throw Exception('Error updating post remotely');
       }
     }


}