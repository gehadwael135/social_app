import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:social_app/features/add_post_screen/presentation/ui_screen/add_post.dart';
import 'package:social_app/features/chat_screen/presentation/ui_screen/chat_screen.dart';
import 'package:social_app/features/home_screen/presentation/ui_screen/home_screen.dart';
import 'package:social_app/features/setting_screen/presentation/ui_screen/setting_screen.dart';
import 'package:social_app/features/user_screen/presentation/ui_screen/user_scree.dart';

part 'social_layout_state.dart';

class SocialLayoutCubit extends Cubit<SocialLayoutState> {
  SocialLayoutCubit() : super(SocialLayoutInitial());
  int currentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    UsersScreen(),
    AddPost(),
    UserScree(),
    SettingScreen(),
  ];
  List<String> title = [
    "Home",
    "Chats",
    "Add Post",
    "Users",
    "Setting"
  ];
  void changIndex(int index) {
    
      currentIndex = index;
    
    
    emit(SocialLayoutSuccess());
  }
}
