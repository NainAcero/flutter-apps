import 'package:chat/ui/screens/chat_screen.dart';
import 'package:chat/ui/size_config.dart';
import 'package:chat/ui/style.dart';
import 'package:chat/ui/widgets/cards/conversation_card.dart';
import 'package:flutter/material.dart';

class ConversationsScreen extends StatefulWidget {
  @override
  _ConversationsScreenState createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ConversationsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Style.darkColor,
        title: Text('Conversations'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () async {
            
          },
          icon: Icon(Icons.search),
        ),
      ),
      body: Center(
        child: ListView.builder(
          padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
           itemCount: 4,
            itemBuilder: (context, index) => ConversationCard(
            onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => ChatScreen()));
            }),
        ),
      ),
    );
  }
}