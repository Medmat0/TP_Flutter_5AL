import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tp_flutter_el_matror_yassine/shared/model/post_model.dart';
import 'package:tp_flutter_el_matror_yassine/shared/services/post_repository.dart';
import '../../app_exception.dart';
import 'dart:developer' as developer;


part 'post_form_event.dart';
part 'post_form_state.dart';

class PostFormBloc extends Bloc<PostFormEvent, PostFormState> {
  final PostRepository postRepository;

  PostFormBloc({required this.postRepository}) : super(const PostFormState()) {
    on<CreatePostEvent>((event, emit) async {
      emit(state.copyWith(status: PostFormStatus.submitting));

      try {
        await postRepository.createPost(event.newPost);
        developer.log(event.newPost.description);

        emit(state.copyWith(status: PostFormStatus.success));
      } catch (error) {
        final appException = AppException.from(error);
        emit(state.copyWith(
          status: PostFormStatus.error,
          exception: appException,
        ));
      }
    });

    on<UpdatePostEvent>((event, emit) async {
      emit(state.copyWith(status: PostFormStatus.submitting));

      try {
        await postRepository.updatePost(event.updatedPost);
        emit(state.copyWith(status: PostFormStatus.success));
      } catch (error) {
        final appException = AppException.from(error);
        emit(state.copyWith(
          status: PostFormStatus.error,
          exception: appException,
        ));
      }
    });
  }
}
