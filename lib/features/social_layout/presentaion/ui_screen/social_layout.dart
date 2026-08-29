import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/social_layout/presentaion/controler/cubit/social_layout_cubit.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit, SocialLayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: Column(
            mainAxisSize: .min,
            children: [
              CurvedNavigationBar(
                backgroundColor: Colors.blue,
                animationDuration: Duration(milliseconds: 400),

                items: [
                  Icon(Icons.home_outlined, size: 32, color: Colors.black),
                  Icon(Icons.forum_outlined, size: 32, color: Colors.black),
                  Icon(Icons.add_box_outlined, size: 32, color: Colors.black),
                  Icon(Icons.people_outline, size: 32, color: Colors.black),
                  Icon(Icons.settings_outlined, size: 32, color: Colors.black),
                ],
                onTap: (index) {
                  context.read<SocialLayoutCubit>().changIndex(index);
                },
              ),
              SizedBox(height: 20),
            ],
          ),
          appBar: AppBar(
            title: Text(
              context.read<SocialLayoutCubit>().title[context
                  .read<SocialLayoutCubit>()
                  .currentIndex],
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            actions: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search_rounded,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: context
              .read<SocialLayoutCubit>()
              .screens[context.read<SocialLayoutCubit>().currentIndex],
        );
      },
    );
  }
}
