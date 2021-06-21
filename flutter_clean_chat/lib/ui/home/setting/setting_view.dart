
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_chat/app_theme_cubit.dart';
import 'package:flutter_clean_chat/navigator_utils.dart';
import 'package:flutter_clean_chat/ui/home/setting/setting_cubit.dart';
import 'package:flutter_clean_chat/ui/sign_in/signin_view.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class SettingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final OwnUser? user = StreamChat.of(context).client.state.user;
    final image = user?.extraData['image'];

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              SettingSwitchCubit(context.read<AppThemeCubit>().isDark),
        ),
        BlocProvider(
          create: (_) => SettingsLogoutCubit(context.read()),
        ),
      ],
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              if (image != null) Image.network(image, height: 150,) else Placeholder(),
              BlocBuilder<SettingSwitchCubit, bool>(
                builder: (context, snapshot) {
                  return Switch(
                    value: snapshot, 
                    onChanged: (value){
                      context.read<SettingSwitchCubit>().onChangeDarkMode(value);
                      context.read<AppThemeCubit>().updateTheme(value);
                    }
                  );
                },
              ),
              Builder(builder: (context) {
                return BlocListener<SettingsLogoutCubit, void>(
                  listener: (context, snapshot) {
                    popAllAndPush(context, SignInView());
                  },
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<SettingsLogoutCubit>().logOut();
                    },
                    child: Text('LOGOUT')
                  ),
                );
              },
              )
            ],
          ),
        ),
      ),
    );
  }
}
