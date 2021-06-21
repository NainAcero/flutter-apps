
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_chat/domain/model/chat_user.dart';
import 'package:flutter_clean_chat/navigator_utils.dart';
import 'package:flutter_clean_chat/ui/home/chat/chat_view.dart';
import 'package:flutter_clean_chat/ui/home/chat/selection/friend_selection_cubit.dart';
import 'package:flutter_clean_chat/ui/home/chat/selection/group_selection_view.dart';
import 'package:flutter_clean_chat/utils/data_utils.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class FriendAndSelectionView extends StatelessWidget {

  void _createFriendChannel(BuildContext context, ChatUserState chatUserState) async {
    final channel = await context.read<FriendsSelectionCubit>().createFriendChannel(chatUserState);
    pushAndReplaceToPage(context, 
      Scaffold(
        body: StreamChannel(
          channel: channel,
          child: ChannelPage(),
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => FriendsSelectionCubit(context.read())..init()),
        BlocProvider(create: (_) => FriendsGroupCubit())
      ],
      child: BlocBuilder<FriendsGroupCubit, bool>(
        builder: (context, isGroup) {
          return BlocBuilder<FriendsSelectionCubit, List<ChatUserState>>(
            builder: (context, snapshot) {
              final selectedUsers = context.read<FriendsSelectionCubit>().selectedUsers;

              return Scaffold(
                floatingActionButton: isGroup && selectedUsers.isNotEmpty
                  ? FloatingActionButton(
                    onPressed: (){
                      print('display group');
                      pushAndReplaceToPage(context, GroupSelectionView(selectedUsers));
                    }
                  )
                  : null,
                body: Column(
                  children: [
                    if(isGroup)
                      Row(
                        children: [
                          BackButton(
                            onPressed: () {
                              print('change to group');
                              context.read<FriendsGroupCubit>().changeToGroup();
                            },
                          ),
                          Text('New group'),
                        ],
                      )
                    else
                      Row(
                        children: [
                          BackButton(
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                          ),
                          Text('People')
                        ],
                      ),
                      if(!isGroup)
                        ElevatedButton(
                          onPressed: (){
                            print('Create group');
                            context.read<FriendsGroupCubit>().changeToGroup();
                          },
                          child: Text('Create Group')
                        )
                      else if(isGroup && selectedUsers.isEmpty) 
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(),
                            Text('Add a friend')
                          ],
                        )
                      else 
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: selectedUsers.length,
                            itemBuilder: (BuildContext context, int index) {
                              final chatUserState = selectedUsers[index];
                              return Stack(
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CircleAvatar(),
                                      Text(chatUserState.chatUser.name!)
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: (){
                                      context.read<FriendsSelectionCubit>().selectUser(chatUserState);
                                    }, 
                                    icon: Icon(Icons.delete)
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.length,
                          itemBuilder: (BuildContext context, int index) { 

                            final chatUserState = snapshot[index];

                            return ListTile(
                              onTap: (){
                                _createFriendChannel(context,chatUserState);
                              },
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  (chatUserState.chatUser.image ?? DataUtils.getUserImage(chatUserState.chatUser.name!))
                                ),
                              ),
                              title: Text(chatUserState.chatUser.name!),
                              trailing: isGroup
                                ? Checkbox(
                                  value: chatUserState.selected, 
                                  onChanged: (val){
                                    print('select user for group');
                                    context.read<FriendsSelectionCubit>().selectUser(chatUserState);
                                  }
                                )
                              : null
                            );
                          },
                        ),
                      )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
