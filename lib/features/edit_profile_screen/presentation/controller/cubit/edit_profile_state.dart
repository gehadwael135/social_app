part of 'edit_profile_cubit.dart';

@immutable
sealed class EditProfileState {}

final class EditProfileInitial extends EditProfileState {}
final class EditProfileSuccess extends EditProfileState {}
final class EditProfileImageSuccess extends EditProfileState {}
