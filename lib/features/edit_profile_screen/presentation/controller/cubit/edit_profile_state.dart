part of 'edit_profile_cubit.dart';

@immutable
sealed class EditProfileState {}

final class EditProfileInitial extends EditProfileState {}
final class EditProfileSuccess extends EditProfileState {}
final class EditProfileImageSuccess extends EditProfileState {}
final class EditProfileLoading extends EditProfileState {}

final class EditProfileUpdateSuccess extends EditProfileState {}

final class EditProfileError extends EditProfileState {
  final String error;

  EditProfileError(this.error);
}
final class GetUserSuccess extends EditProfileState {}
