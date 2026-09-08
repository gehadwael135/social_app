import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/utils/widgets/custom_text_field.dart';
import 'package:social_app/features/edit_profile_screen/presentation/controller/cubit/edit_profile_cubit.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit()..getUserData(),
      child: BlocConsumer<EditProfileCubit, EditProfileState>(
        listener: (context, state) {
           if (state is GetUserSuccess) {
    final cubit = context.read<EditProfileCubit>();

    nameController.text = cubit.UserData?['name'] ?? '';
    bioController.text = cubit.UserData?['bio'] ?? '';
  }

  if (state is EditProfileUpdateSuccess) {

      ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Profile is Update")));
         
    Navigator.pop(context, true);
  }

  if (state is EditProfileError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(state.error),
      ),
    );
  }
        },
        builder: (context, state) {
          final cubit = context.read<EditProfileCubit>();

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
              title: const Text(
                'Edit Profile',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    state is EditProfileLoading
                        ? null
                        : cubit.updateProfile(
                            name: nameController.text,
                            bio: bioController.text,
                          );
                  },
                  child: const Text(
                    'UPDATE',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),

            body: SingleChildScrollView(
              child: Column(
                children: [
                  _buildProfileImages(cubit),

                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: CustomTextField(
                      text: 'e.g: Gehad Wael',
                      icon: Icons.people,
                      label: 'Name',
                      controller: nameController,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 20,
                    ),
                    child: CustomTextField(
                      text: 'Write Your Bio ...',
                      icon: Icons.border_color_outlined,
                      label: 'Bio',
                      controller: bioController,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileImages(EditProfileCubit cubit) {
    return Column(
      children: [
        // Cover Image
        Stack(
          alignment: Alignment.topRight,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(7),
                  topRight: Radius.circular(7),
                ),
                child: cubit.image != null
                    ? Image.file(
                        File(cubit.image!.path),
                        width: double.infinity,
                        height: 160,
                        fit: BoxFit.cover,
                      )
                    : Image.network(cubit.UserData?["cover"]??
                        'https://tse1.mm.bing.net/th/id/OIP.yN8YpTjgLlVqQRY5gu3QHQAAAA?r=0&pid=Api&h=220&P=0',
                        width: double.infinity,
                        height: 160,
                        fit: BoxFit.cover,
                      ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 25, right: 20),
              child: _cameraButton(onTap: cubit.pickImage),
            ),
          ],
        ),

        // Profile Image
        Transform.translate(
          offset: const Offset(0, -60),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              _buildProfileImage(cubit),

              Transform.translate(
                offset: const Offset(-5, 5),
                child: _cameraButton(onTap: cubit.pickImageProfile),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileImage(EditProfileCubit cubit) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        radius: 50,
        backgroundImage: cubit.profileImage != null
            ? FileImage(File(cubit.profileImage!.path))
            :  NetworkImage(
                cubit.UserData?["image"]??
                        'https://tse1.mm.bing.net/th/id/OIP.yN8YpTjgLlVqQRY5gu3QHQAAAA?r=0&pid=Api&h=220&P=0',     ),
      ),
    );
  }

  Widget _cameraButton({required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: const CircleAvatar(
        radius: 20,
        backgroundColor: Colors.blue,
        child: Icon(Icons.camera_alt_outlined, size: 20, color: Colors.white),
      ),
    );
  }
}
