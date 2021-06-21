
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_chat/navigator_utils.dart';
import 'package:flutter_clean_chat/ui/home/home_view.dart';
import 'package:flutter_clean_chat/ui/profile_verify/profile_verify_cubit.dart';

class ProfileVerifyView extends StatelessWidget {

  ProfileVerifyView();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileVeriFyCubit(context.read(), context.read()),
        child: BlocConsumer<ProfileVeriFyCubit, ProfileState>(
        listener: (context, snapshot) {
          if(snapshot.success) {
            pushAndReplaceToPage(context, HomeView());
          }
        },
        builder: (context, snapshot) {
          // refresh the photo
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Verify your identity'),
                  if(snapshot.file != null) Image.file(snapshot.file!, height: 150,)
                  else
                    Placeholder(
                      fallbackHeight: 100,
                      fallbackWidth: 100,
                    ),
                  IconButton(        
                    onPressed: () => context.read<ProfileVeriFyCubit>().pickImage(), 
                    icon: Icon(Icons.photo)
                  ),
                  Text('Your name'),
                  TextField(
                    controller: context.read<ProfileVeriFyCubit>().nameController,
                    decoration: InputDecoration(
                      hintText: 'Or just how people now you'
                    ),
                  ),
                  ElevatedButton(
                    child: Text('Start chatting now'),
                    onPressed: () {
                      context.read<ProfileVeriFyCubit>().startChatting();
                    },
                  ),
                ],
              ),
            ),
          );
        }
      )
    );
  }
}