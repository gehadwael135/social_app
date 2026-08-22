import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/utils/widgets/custom_button.dart';
import 'package:social_app/features/edit_profile_screen/presentation/ui_screen/edit_profile.dart';
import 'package:social_app/features/setting_screen/presentation/controler/cubit/setting_cubit.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingCubit()..getUserData(),
      child: Scaffold(
        body: BlocConsumer<SettingCubit, SettingState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = context.read<SettingCubit>();
            return Column(
              children: [
                Stack(
                  alignment: .bottomCenter,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(7),
                          topRight: Radius.circular(7),
                        ),
                        child: Image.network(
                          cubit.UserData?['cover'] ??
                              "https://tse1.mm.bing.net/th/id/OIP.yN8YpTjgLlVqQRY5gu3QHQAAAA?r=0&pid=Api&h=220&P=0",
                          fit: BoxFit.cover,
                          height: 160,
                          width: .infinity,
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0, 30),
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                            cubit.UserData?['image'] ??
                                "https://tse1.mm.bing.net/th/id/OIP.yN8YpTjgLlVqQRY5gu3QHQAAAA?r=0&pid=Api&h=220&P=0",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
               
                SizedBox(height: 37),
                Text(
                  cubit.UserData?["name"] ?? "User Name",
                  style: TextStyle(fontSize: 18, fontWeight: .w600),
                ),
                SizedBox(height: 5),
                Text(
                  cubit.UserData?["bio"] ?? "bio ...",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: .w400,
                    color: Colors.black26,
                  ),
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: .spaceAround,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text(
                            "100",
                            style: TextStyle(fontSize: 16, fontWeight: .w500),
                          ),
                          Text(
                            "Post",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: .w600,
                              color: Colors.black26,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text(
                            "265",
                            style: TextStyle(fontSize: 16, fontWeight: .w500),
                          ),
                          Text(
                            "Photos",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: .w600,
                              color: Colors.black26,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text(
                            "10K",
                            style: TextStyle(fontSize: 16, fontWeight: .w500),
                          ),
                          Text(
                            "Followers",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: .w600,
                              color: Colors.black26,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text(
                            "64",
                            style: TextStyle(fontSize: 16, fontWeight: .w500),
                          ),
                          Text(
                            "Followings",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: .w600,
                              color: Colors.black26,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: .spaceAround,
                    children: [
                      SizedBox(
                        width: 240,
                        height: 40,
                        child: cutomButton(
                          child: Text(
                            "Add Photos",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: .w600,
                              fontSize: 18,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(
                        width: 95,
                        height: 40,
                        child: cutomButton(
                          child: Icon(
                            Icons.edit_outlined,
                            size: 23,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProfile(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
