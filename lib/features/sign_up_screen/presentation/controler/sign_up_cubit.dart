import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/sign_up_screen/presentation/controler/sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<void> signUp({
    required String name,
    required email,
    required password,
  }) async {
    try {
      emit(SignUpLoading());
      UserCredential credential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(SignUpSuccess());

      await FirebaseFirestore.instance
          .collection("Users")
          .doc(credential.user!.uid)
          .set({
            "name": name,
            "email": email,
            "userId": credential.user!.uid,
            "image": "https://images.squarespace-cdn.com/content/v1/52fd615de4b0feb85ec2833f/1583271314308-3ENJECU3U0MOMWTD36HW/Social+Media+Photography",
                      
            "cover":
                "https://neatphotorest.com/wp-content/uploads/2024/09/Social-media-photography-tips.jpg",
         "bio":"Write Your Bio ..."
          });
      
      emit(CreatUserSuccess());

    } catch (e) {
      emit(SignUpError(e.toString()));
    }
  }

//   Map<String, dynamic>? UserData;
//   Future<void> getUserData() async {
//   var value = await FirebaseFirestore.instance
//       .collection("Users")
//       .doc(FirebaseAuth.instance.currentUser!.uid)
//       .get();

//   UserData = value.data();

//   emit(GetUserSuccess());
// }

  bool isScure = false;
  bool isScureConfirmPassword = false;
  void changeScure() {
    isScure = !isScure;

    emit(SecureSuccess());
  }

  void scureConfirmPassword() {
    isScureConfirmPassword = !isScureConfirmPassword;

    emit(SecureSuccess());
  }
}
