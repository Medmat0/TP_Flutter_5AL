part of 'post_list_bloc.dart';

enum PostListStatus { initial, loading, success, error }

class PostListState {
  final PostListStatus status;
  final List<Post> posts;
  final AppException? exception;

  const PostListState({
    this.status = PostListStatus.initial,
    this.posts = const [],
    this.exception,
  });

  PostListState copyWith({
    PostListStatus? status,
    List<Post>? posts,
    AppException? exception,
  }) {
    return PostListState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      exception: exception ?? this.exception,
    );
  }
}
