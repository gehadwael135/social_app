import 'package:bloc/bloc.dart';
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
  }
}
