import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<void> signIn({required email, required password}) async {
    try {
      emit(SignInLoading());
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(SignInSuccess());

    } catch (e) {
      emit(SignInError(e.toString()));
      
    }
  }
   bool isScure = false;
  
  void changeScure() {
    isScure = !isScure;

    emit(SecureSuccess());
  }

}
