part of 'add_post_cubit.dart';

@immutable
sealed class AddPostState {}

final class AddPostInitial extends AddPostState {}

final class AddPoatLosding extends AddPostState {}

final class AddPostSuccess extends AddPostState {}

final class AddPostError extends AddPostState {
  final String error;
  AddPostError(this.error);
}

final class AddPhotoSuccess extends AddPostState {}
final class UserDataSuccess extends AddPostState {}
