abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpError extends SignUpState {
  final String message;

  SignUpError(this.message);
}
class CreatUserSuccess extends SignUpState {}

class CreatUserError extends SignUpState {
  final String message;

  CreatUserError(this.message);
}
class SecureSuccess extends SignUpState {}
class GetUserSuccess extends SignUpState {}