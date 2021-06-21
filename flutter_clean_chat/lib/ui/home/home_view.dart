import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_chat/navigator_utils.dart';
import 'package:flutter_clean_chat/ui/home/chat/chat_view.dart';
import 'package:flutter_clean_chat/ui/home/chat/selection/friend_and_selection_view.dart';
import 'package:flutter_clean_chat/ui/home/home_cubit.dart';
import 'package:flutter_clean_chat/ui/home/setting/setting_view.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Column(
        children: [
          Expanded(
            child: BlocBuilder<HomeCubit, int>(
              builder: (context, snapshot) {
                return IndexedStack(
                  index: snapshot,
                  children: [ChatView(), SettingView()],
                );
              },
            ),
          ),
          HomeNavigatorBar()
        ],
      ),
    );
  }
}

class HomeNavigatorBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              context.read<HomeCubit>().onChangeTap(0);
            }, 
            child: Text('Chats')
          ),
          FloatingActionButton(
            onPressed: () {
              pushToPage(context, FriendAndSelectionView());
            },
            child: Icon(Icons.add),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<HomeCubit>().onChangeTap(1);
            }, 
            child: Text('Settings')
          ),
        ],
      ),
    );
  }
}
