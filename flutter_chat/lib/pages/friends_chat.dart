import 'package:flutter/material.dart';
import 'package:flutter_chat/utils/data_utils.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class FriendsChat extends StatefulWidget {
  @override
  _FriendsChatState createState() => _FriendsChatState();
}

class _FriendsChatState extends State<FriendsChat> {
  final _keyChannels = GlobalKey<ChannelsBlocState>();
  final _channelController = TextEditingController();

  Future<void> _onCreateChannel() async {
    final result = await showDialog(
      context: context, 
      builder: (context) {

        return AlertDialog(
          title: Text('Create Channel'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller : _channelController,
                decoration: InputDecoration(
                  hintText: 'Channel Name'
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(
                  _channelController.text
                ), 
                child: Text('Save')
              )
            ],
          ),
        );
      }
    );

    if(result != null) {
      
      final client = StreamChat.of(context).client;
      final channel = client.channel('messaging', id: _channelController.text, extraData: {
        'name': _channelController.text,
        'image': DataUtils.getChannelImage()
      });

      await channel.create();
      _keyChannels.currentState!.queryChannels();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _onCreateChannel, 
        label: Text('Create Channel')
      ),
      appBar: AppBar(
        title: Text('Public Chat'),
      ),
      body: ChannelsBloc(
        key: _keyChannels,
        child: ChannelListView(
          channelWidget: ChannelPage(),
        ),
      ),
    );
  }
}

class ChannelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChannelHeader(),
      body: Column(
        children: [
          Expanded(
            child: MessageListView(),
          ),
          MessageInput()
        ],
      ),
    );
  }
}