import 'package:flutter/material.dart';
import 'package:flutter_chat/pages/home_chat.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late StreamChatClient _client;

  @override
  void initState() {
    _client = StreamChatClient(
      '65sbm2hguq6r',
      logLevel: Level.INFO
    );
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      builder: (context, child) {
        return StreamChat(
          child: child,
          client: _client,
        );
      },
      home: HomeChat(),
    );
  }
}