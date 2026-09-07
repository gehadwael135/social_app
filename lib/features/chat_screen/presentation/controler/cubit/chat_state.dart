part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}
class ChatLoading extends ChatState {}

class ChatSuccess extends ChatState {}

class ChatError extends ChatState {
  final String message;

  ChatError(this.message);
}
class ChatemojiesSuccess extends ChatState {}
class HidEmojiesSuccess extends ChatState {}