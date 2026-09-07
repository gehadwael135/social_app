part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final List<QueryDocumentSnapshot> posts;

  HomeSuccess(this.posts);
}

final class HomeError extends HomeState {
  final String error;

  HomeError(this.error);
}
final class LikeSuccess extends HomeState {}