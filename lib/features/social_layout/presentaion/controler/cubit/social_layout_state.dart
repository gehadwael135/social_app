part of 'social_layout_cubit.dart';

@immutable
sealed class SocialLayoutState {}

final class SocialLayoutInitial extends SocialLayoutState {}
final class SocialLayoutLoading extends SocialLayoutState {}
final class SocialLayoutSuccess extends SocialLayoutState {}
final class SocialLayoutError extends SocialLayoutState {}
