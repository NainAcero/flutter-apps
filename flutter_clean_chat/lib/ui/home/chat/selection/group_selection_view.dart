import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_chat/navigator_utils.dart';
import 'package:flutter_clean_chat/ui/home/chat/chat_view.dart';
import 'package:flutter_clean_chat/ui/home/chat/selection/friend_selection_cubit.dart';
import 'package:flutter_clean_chat/ui/home/chat/selection/group_selection_cubit.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class GroupSelectionView extends StatelessWidget {
  final List<ChatUserState> selectedUsers;

  const GroupSelectionView(this.selectedUsers, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GroupSelectionCubit(selectedUsers, context.read(), context.read()),
      child: BlocConsumer<GroupSelectionCubit, GroupSelectionState>(
        listener: (context, snapshot) {
          if(snapshot.channel != null) {
            pushAndReplaceToPage(
              context,
              Scaffold(
                body: StreamChannel(
                  channel: snapshot.channel,
                  child: ChannelPage(),
                ),
              ) 
            );
          }
        },
        builder: (context, snapshot) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Verify your identity'),
                  if(snapshot != null && snapshot.file != null)
                    Image.file(
                      snapshot.file!,
                      height: 150,
                    )
                  else 
                    Placeholder(
                      fallbackHeight: 100,
                      fallbackWidth: 100,
                    ),
                  IconButton(
                    onPressed: context.read<GroupSelectionCubit>().pickImage, 
                    icon: Icon(Icons.photo)
                  ),
                  TextField(
                    controller: context.read<GroupSelectionCubit>().nameTextController,
                    decoration: InputDecoration(
                      hintText: 'Name of the group'
                    ),
                  ),
                  Wrap(
                    children: List.generate(
                      selectedUsers.length, 
                      (index) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(),
                          Text(selectedUsers[index].chatUser.name!)
                        ],
                      )
                    )
                  ),
                  ElevatedButton(
                    onPressed: context.read<GroupSelectionCubit>().createGroup, 
                    child: Text('Next')
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
