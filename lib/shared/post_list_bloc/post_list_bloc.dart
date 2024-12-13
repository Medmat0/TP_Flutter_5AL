import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tp_flutter_el_matror_yassine/shared/model/post_model.dart';
import 'package:tp_flutter_el_matror_yassine/shared/services/post_repository.dart';
import '../../app_exception.dart';

part 'post_list_event.dart';
part 'post_list_state.dart';

class PostListBloc extends Bloc<PostListEvent, PostListState> {
  final PostRepository postRepository;


  PostListBloc({required this.postRepository}) : super(PostListState()) {
    on<LoadPostsEvent>(_onLoadPosts);
    on<AddPostEvent>(_onAddPost);
    on<UpdatePostEvent>(_onUpdatePost);
  }

  Future<void> _onLoadPosts(
      LoadPostsEvent event,
      Emitter<PostListState> emit,
      ) async {
    emit(state.copyWith(status: PostListStatus.loading));
    try {
      final posts = await postRepository.getAllPost();
      emit(state.copyWith(status: PostListStatus.success, posts: posts));
    } catch (e) {
      final appException = AppException.from(e);
      emit(state.copyWith(status: PostListStatus.error, exception: appException));
    }
  }

  Future<void> _onAddPost(
      AddPostEvent event,
      Emitter<PostListState> emit,
      ) async {
    await postRepository.createPost(event.newPost);
    add(LoadPostsEvent());
  }

  Future<void> _onUpdatePost(
      UpdatePostEvent event,
      Emitter<PostListState> emit,
      ) async {
    await postRepository.updatePost(event.updatedPost);
    add(LoadPostsEvent());
  }
}
