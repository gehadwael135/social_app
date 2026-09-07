import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/features/chat_screen/presentation/controler/cubit/chat_cubit.dart';
import 'package:social_app/features/chat_screen/presentation/ui_screen/chat_details_screen.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final users = snapshot.data?.docs ?? [];

          final otherUsers = users
              .where((user) => user.id != currentUserId)
              .toList();

          return ListView.builder(
            itemCount: otherUsers.length,

            itemBuilder: (context, index) {
              final data = otherUsers[index].data() as Map<String, dynamic>;

              return ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),

                title: Text(data['name'] ?? ''),

                subtitle: Text(data['email'] ?? ''),

                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (_) => ChatCubit(),

                        child: ChatScreen(
                          receiverId: otherUsers[index].id,
                          receiverName: data['name'],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
