import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMassage extends StatefulWidget {
  const NewMassage({super.key});

  @override
  State<NewMassage> createState() => _NewMassageState();
}

class _NewMassageState extends State<NewMassage> {
  var _enteredMessage = '';
  final _controller = new TextEditingController();
  void _sendMessage() {
    FocusScope.of(context).unfocus();
    FirebaseFirestore.instance.collection('chat').add(
      {
        'text': _enteredMessage,
        'createdAt': Timestamp.now(),
      },
    );
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'Send a message....'),
                onChanged: (value) {
                  setState(() {
                    _enteredMessage = value;
                  });
                }),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(Icons.send),
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
          ),
        ],
      ),
    );
  }
}
