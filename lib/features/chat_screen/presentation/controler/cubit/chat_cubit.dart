import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:social_app/features/chat_screen/domain/entities/message_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final FirebaseAuth auth = FirebaseAuth.instance;

//first step to do pagination => loading limited messages
  DocumentSnapshot? firstDocument;
bool hasMoreMessages = true;
bool isLoadingMore = false;

final List<MessageModel> messages = [];

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

      final chatId = getChatId(currentUser.uid, receiverId);

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

  Stream<List<MessageModel>> getMessages(String receiverId) {
    final currentUser = auth.currentUser!;

    final chatId = getChatId(currentUser.uid, receiverId);

    return firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp').limitToLast(20)
        .snapshots()
        .map((snapshot) {


          //second step in pagination => to get last 20 message in document
          if (snapshot.docs.isNotEmpty) {
          firstDocument = snapshot.docs.first;
        }

        final latestMessages = snapshot.docs.map((doc) {
          return MessageModel.fromMap(doc.data());
        }).toList();

       if (messages.isEmpty) {
          messages.addAll(latestMessages);
        } else {
          
          for (final message in latestMessages) {
            final exists = messages.any(
              (oldMessage) =>
                  oldMessage.text == message.text,
            );

            if (!exists) {
              messages.add(message);
            }
          }
        }

        return messages;
        });
  }
final FocusNode focusNode = FocusNode();
  bool isEmojiPickerVisible = false;

  void toggleEmojiPicker() {
    isEmojiPickerVisible = !isEmojiPickerVisible;
    if (isEmojiPickerVisible) {
      focusNode.unfocus(); // Hide keyboard when emoji picker is shown
    } else {
      focusNode.requestFocus(); // Show keyboard when emoji picker is hidden
    }
    emit(ChatemojiesSuccess());
  }
  void hideEmojiPicker() {
  isEmojiPickerVisible = false;
  emit(HidEmojiesSuccess());
}


//step 3 in pagination => load more messages function 
Future<void> loadMoreMessages(String receiverId) async {
  if (firstDocument == null || isLoadingMore || !hasMoreMessages) {
    return;
  }

  isLoadingMore = true;

  try {
    final currentUser = auth.currentUser!;
    final chatId = getChatId(currentUser.uid, receiverId);

    final snapshot = await firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp')
        .endBeforeDocument(firstDocument!)
        .limitToLast(20)
        .get();

    if (snapshot.docs.isEmpty) {
      hasMoreMessages = false;
      return;
    }

    firstDocument = snapshot.docs.first;

    final oldMessages = snapshot.docs.map((doc) {
      return MessageModel.fromMap(doc.data());
    }).toList();

    // Add old messages before current messages
    messages.insertAll(0, oldMessages);

    if (snapshot.docs.length < 20) {
      hasMoreMessages = false;
    }

    emit(ChatSuccess());
  } finally {
    isLoadingMore = false;
  }
}




}
