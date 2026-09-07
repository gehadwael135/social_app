import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'add_post_state.dart';

class AddPostCubit extends Cubit<AddPostState> {
  AddPostCubit() : super(AddPostInitial());

  final picker = ImagePicker();
  XFile? image;
  Future<XFile?> pickImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      emit(AddPhotoSuccess());
    }
    return null;
  }
//upload Image To Cloudinary 
Future<String?> uploadImageToCloudinary() async {
  if (image == null) return null;

  try {
    final dio = Dio();

    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        image!.path,
        filename: image!.name,
      ),
      'upload_preset': 'imxduvvk',
    });

    final response = await dio.post(
      'https://api.cloudinary.com/v1_1/yec8xz7j/image/upload',
      data: formData,
    );

    return response.data['secure_url'];
  } catch (e) {
    print('Cloudinary upload error: $e');
    return null;
  }
}





String? userName;
String? userImage;

Future<void> getUserData() async {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) return;

  final doc = await FirebaseFirestore.instance
      .collection("Users")
      .doc(user.uid)
      .get();

  if (doc.exists) {
    final data = doc.data()!;

    userName = data["name"];
    userImage = data["image"];

    emit(UserDataSuccess());
  }
}

  Future<void> createPost({
  required String text,required String tags
}) async {
  try {
    emit(AddPoatLosding());

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      emit(AddPostError("User is not logged in"));
      return;
    }

    // Get current user data from Firestore
    final userData = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .get();

    if (!userData.exists) {
      emit(AddPostError("User data not found"));
      return;
    }

    final data = userData.data()!;

    String imageUrl = '';

    if (image != null) {
      final uploadedImageUrl = await uploadImageToCloudinary();

      if (uploadedImageUrl == null) {
        emit(AddPostError("Failed to upload image"));
        return;
      }

      imageUrl = uploadedImageUrl;
    }

    await FirebaseFirestore.instance.collection('posts').add({
      'userId': user.uid,
      'userName': data['name'] ?? 'User Name',
      'userImage': data['image'] ?? '',
      'text': text,
      'tags':tags,
      'imageUrl': imageUrl,
      'likesCount': 0,
      'createdAt': FieldValue.serverTimestamp(),
    });

    emit(AddPostSuccess());
  } catch (e) {
    emit(AddPostError(e.toString()));
  }
}

}
