import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/add_post_screen/presentation/controller/cubit/add_post_cubit.dart';

class AddPost extends StatelessWidget {
  const AddPost({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddPostCubit(),
      child: Scaffold(
          body: BlocConsumer<AddPostCubit, AddPostState>(
            listener: (context, state) {
            },
            builder: (context, state) {
              var cubit=context.read<AddPostCubit>();
              return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 23,
                                backgroundImage: NetworkImage(
                                  "https://images.squarespace-cdn.com/content/v1/52fd615de4b0feb85ec2833f/1583271314308-3ENJECU3U0MOMWTD36HW/Social+Media+Photography",
                                ),
                              ),
                              SizedBox(width: 15),
                              Text(
                                "Gehad Wael",
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "What is on Your Mind ...",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                       if (cubit.image != null)
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 15),
                         child: ClipRRect(borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                             File(cubit.image!.path),
                             width: double.infinity,
                             height: 250,
                             fit: BoxFit.cover,
                           ), 
                         ),
                       )
    
                    ,    Row(
                          mainAxisAlignment: .center,
                          children: [
                            TextButton(
                              onPressed: () {cubit.pickImage();},
                              child: Row(
                                children: [
                                  Icon(Icons.photo),
                                  SizedBox(width: 5),
                                  Text("add photo"),
                                ],
                              ),
                            ),
                            TextButton(onPressed: () {}, child: Text("#tags")),
                            SizedBox(height: 80),
                          ],
                        ),
                      ],
                    );
            },
          ),
        ),
    );
  }
}
