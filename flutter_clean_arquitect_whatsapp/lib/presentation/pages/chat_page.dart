import 'package:flutter/material.dart';
import 'package:flutter_clean_arquitect_whatsapp/domain/entities/user_entity.dart';

class ChatPage extends StatefulWidget {
  final UserEntity userInfo;

  const ChatPage({Key? key, required this.userInfo}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}