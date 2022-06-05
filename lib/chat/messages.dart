import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_signup_project/chat/message_bubble.dart';

class Massages extends StatelessWidget {
  const Massages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, AsyncSnapshot<dynamic> chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            reverse: true,
            itemCount: chatSnapshot.data!.docs.length,
            itemBuilder: (ctx, index) => MessageBubble(
              chatSnapshot.data!.docs[index]['text'],
            ),
          );
        });
  }
}





// final chatDocs = chatSnapshot.data.doc;
//                 return ListView.builder(
//                   reverse: true,
//                   itemCount: chatDocs.length,
//                   itemBuilder: (ctx, index) => MessageBubble(
//                     chatDocs[index]['text'],
//                     chatDocs[index]['username'],
//                   ),
//                 );