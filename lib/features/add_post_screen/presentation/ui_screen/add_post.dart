import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/add_post_screen/presentation/controller/cubit/add_post_cubit.dart';

class AddPost extends StatelessWidget {
  AddPost({super.key});
  final TextEditingController textController = TextEditingController();
  final tagController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddPostCubit()..getUserData(),
      child: Scaffold(
        body: BlocConsumer<AddPostCubit, AddPostState>(
          listener: (context, state) {
            if (state is AddPostSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Post added successfully")),
              );
            }
          },
          builder: (context, state) {
            var cubit = context.read<AddPostCubit>();
            return 
             Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 23,
                        backgroundImage: NetworkImage(
                        cubit.userImage?? "https://tse1.mm.bing.net/th/id/OIP.yN8YpTjgLlVqQRY5gu3QHQAAAA?r=0&pid=Api&h=220&P=0",
                                  ),
                      ),
                      SizedBox(width: 15),
                      Text( cubit.userName??"User Name" ,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    child: SizedBox(width: MediaQuery.of(context).size.width - 50,
                   
                      child: TextFormField(
                        controller: textController,
                        decoration: InputDecoration(
                          hintText: "What is on Your Mind ...",
                        
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                if (cubit.image != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        File(cubit.image!.path),
                        width: double.infinity,
                        height: 230,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 5),
                  child: Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              cubit.pickImage();
                            },
                            child: Row(
                              children: [
                                Icon(Icons.photo),
                                SizedBox(width: 5),
                                Text("add photo"),
                              ],
                            ),
                          ),
                  
                          TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Add Tags"),
                                    content: TextFormField(
                                      controller: tagController,
                                      decoration: InputDecoration(
                                        hintText: "#Tags",
                                        helperStyle: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 20,
                                        ),
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Done"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text("#tags"),
                          ),
                        ],
                      ),
                  
                      TextButton(
                        onPressed: () {
                          cubit.createPost(
                            text: textController.text,
                            tags: tagController.text,
                          );
                        },
                        child: Text(
                          "Post",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 22
                          ),
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
