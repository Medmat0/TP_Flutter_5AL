part of 'post_form_bloc.dart';

enum PostFormStatus { initial, submitting, success, error }

class PostFormState {
  final PostFormStatus status;
  final AppException? exception;

  const PostFormState({
    this.status = PostFormStatus.initial,
    this.exception,
  });

  PostFormState copyWith({
    PostFormStatus? status,
    AppException? exception,
  }) {
    return PostFormState(
      status: status ?? this.status,
      exception: exception ?? this.exception,
    );
  }
}
