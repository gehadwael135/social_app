import 'package:bloc/bloc.dart';
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
}
