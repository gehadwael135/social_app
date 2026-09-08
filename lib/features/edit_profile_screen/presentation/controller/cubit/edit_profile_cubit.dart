import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());
   final picker = ImagePicker();
  XFile? image;
  Future<XFile?> pickImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      emit(EditProfileSuccess());
    }
    return null;
  }
   XFile? profileImage;
  Future<XFile?> pickImageProfile() async {
    profileImage = await picker.pickImage(source: ImageSource.gallery);
    if (profileImage != null) {
      emit(EditProfileImageSuccess());
    }
    return null;
  }


  Future<String?> uploadImageToCloudinary(XFile? selectedImage) async {
    if (selectedImage == null) return null;

    try {
      final dio = Dio();

      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          selectedImage.path,
          filename: selectedImage.name,
        ),
        'upload_preset': 'imxduvvk',
      });

      final response = await dio.post(
        'https://api.cloudinary.com/v1_1/yec8xz7j/image/upload',
        data: formData,
      );

      return response.data['secure_url'];
    } catch (e) {
     
      return null;
    }
  }

   Future<void> updateProfile({
    required String name,
    required String bio,
  }) async {
    try {
      emit(EditProfileLoading());

      final uid = FirebaseAuth.instance.currentUser!.uid;

      String? coverUrl;
      String? profileUrl;

      // Upload Cover
      if (image != null) {
        coverUrl = await uploadImageToCloudinary(image);

        if (coverUrl == null) {
          emit(EditProfileError('Failed to upload cover image'));
          return;
        }
      }

      // Upload Profile Image
      if (profileImage != null) {
        profileUrl = await uploadImageToCloudinary(profileImage);

        if (profileUrl == null) {
          emit(EditProfileError('Failed to upload profile image'));
          return;
        }
      }

      final Map<String, dynamic> data = {
        'name': name,
        'bio': bio,
      };

      if (coverUrl != null) {
        data['cover'] = coverUrl;
      }

      if (profileUrl != null) {
        data['image'] = profileUrl;
      }

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .update(data);

      emit(EditProfileUpdateSuccess());
    } catch (e) {
      emit(EditProfileError(e.toString()));
    }
  }
Map<String, dynamic>? UserData;
 Future<void> getUserData() async {
  var value = await FirebaseFirestore.instance
      .collection("Users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get();

  UserData = value.data();

  emit(GetUserSuccess());
  
}

}
