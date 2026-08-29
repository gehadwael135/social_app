import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:social_app/features/chat_screen/domain/entities/message_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
   final FirebaseFirestore firestore =
      FirebaseFirestore.instance;

  final FirebaseAuth auth = FirebaseAuth.instance;

  String getChatId(String user1, String user2) {
    final ids = [user1, user2];

    ids.sort();

    return ids.join('_');
  }

  Future<void> sendMessage({
    required String receiverId,
    required String text,
  }) async {
    try {
      final currentUser = auth.currentUser;

      if (currentUser == null) return;

      if (text.trim().isEmpty) return;

      final chatId = getChatId(
        currentUser.uid,
        receiverId,
      );

      await firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .add({
        'senderId': currentUser.uid,
        'receiverId': receiverId,
        'text': text.trim(),
        'timestamp': FieldValue.serverTimestamp(),
      });

    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

Stream<List<MessageModel>> getMessages(
  String receiverId,
) {
  final currentUser = auth.currentUser!;

  final chatId = getChatId(
    currentUser.uid,
    receiverId,
  );

  return firestore
      .collection('chats')
      .doc(chatId)
      .collection('messages')
      .orderBy('timestamp')
      .snapshots()
      .map((snapshot) {
        return snapshot.docs.map((doc) {
          return MessageModel.fromMap(
            doc.data(),
          );
        }).toList();
      });
}


}
