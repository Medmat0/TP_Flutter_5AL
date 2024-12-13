import '../remote_data/remote_posts_data.dart';
import '../../model/post_model.dart';


abstract class LocalPostData extends RemotePostData {

  Future<void> save(List<Post> posts);

}