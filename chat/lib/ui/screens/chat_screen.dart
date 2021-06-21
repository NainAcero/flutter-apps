import 'package:chat/ui/size_config.dart';
import 'package:chat/ui/style.dart';
import 'package:chat/ui/widgets/cards/friend_message_card.dart';
import 'package:chat/ui/widgets/cards/my_message_card.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<int> items = [1,0,1,1,0,0,1,0,0,0];
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text('Nain Acero'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.safeBlockHorizontal * 4,
              vertical: SizeConfig.safeBlockVertical * 3,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) =>
              (items[index] == 1)?
                FriendMessageCard():
                MyMessageCard()
          )),
          Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Style.darkColor,
              borderRadius: BorderRadius.circular(32)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: 12,
                ),
                Expanded(
                    child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type your message...',
                      hintStyle: TextStyle()),
                )),
                InkWell(
                   onTap: () async {
                     
                  },
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Style.primaryColor,
                          Style.secondaryColor,
                          Style.secondaryColor,
                          Style.secondaryColor,
                        ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
                  child: Icon(Icons.send)),
                )
              ]
            )
          )
        ]
      )
    );
  }
}