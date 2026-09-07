import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  StreamSubscription<QuerySnapshot>? postsSubscription;

  Future<void> getPosts() async {
    emit(HomeLoading());

    postsSubscription = firestore
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen(
          (snapshot) {
            emit(HomeSuccess(snapshot.docs));
          },
          onError: (error) {
            emit(HomeError(error.toString()));
          },
        );
  }

  @override
  Future<void> close() {
    postsSubscription?.cancel();
    return super.close();
  }

  Future<void> toggleLike(String postId) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    final likeRef = FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(user.uid);

    final likeDoc = await likeRef.get();

    if (likeDoc.exists) {
      // Unlike
      await likeRef.delete();

      await FirebaseFirestore.instance.collection('posts').doc(postId).update({
        'likesCount': FieldValue.increment(-1),
      });
    } else {
      // Like
      await likeRef.set({
        'userId': user.uid,
        'createdAt': FieldValue.serverTimestamp(),
      });

      await FirebaseFirestore.instance.collection('posts').doc(postId).update({
        'likesCount': FieldValue.increment(1),
      });
    }
  }

 
}
