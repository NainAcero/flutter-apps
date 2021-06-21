import 'package:flutter/material.dart';
import 'package:flutter_socketio/models/chat_message.dart';
import 'package:flutter_socketio/utils/consts.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageItem extends StatelessWidget {
  final ChatMessage? message;

  const MessageItem({Key? key, @required this.message }) : super(key: key);

  Widget getUsernameView() {
    return Container(
      padding: EdgeInsets.all(3),
        child: Text(
        message!.username!,
        style: GoogleFonts.quicksand(fontSize: 12, color: Color(0xff718792)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: message!.sender! ? WrapAlignment.end : WrapAlignment.start,
      children: [
        Column(
          crossAxisAlignment: message!.sender!
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
          children: [
            if (!message!.sender!) getUsernameView(),
            Container(
              constraints: BoxConstraints(
                maxWidth: 300,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: message!.sender! ? accentColor : Color(0xff455a64),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(message!.sender! ? 30 : 0),
                  bottomRight: Radius.circular(!message!.sender! ? 30 : 0),
                ),
              ),
              child: Text(
                message!.message!,
                style: GoogleFonts.quicksand(),
              ),

            ),
            if (message!.sender!) getUsernameView(),
            SizedBox(height: 20),
          ]
        )
      ]
    );
  }
}