import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/home/bloc.dart';
import 'package:flutter_app/db/app_theme.dart';
import 'package:flutter_app/models/artist.dart';
import 'package:flutter_app/widgets/rounded_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final HomeBloc bloc = HomeBloc.of(context);
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (_, state) {

        if (state.status != HomeStatus.selecting) {
          return Container(height: 0);
        }

        final List<Artist> artistsSelected =
            state.artists.where((element) => element.selected).toList();
        
        final int count = artistsSelected.length;
        return Container(
          color: MyAppTheme.instance.darkEnabled
              ? MyAppTheme.instance.darkColor
              : Colors.white,
          padding: EdgeInsets.all(10),
          child: SafeArea(
            top: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Select at least 5 artists",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                RoundedButton(
                  onPressed: count >= 5
                      ? () {
                        bloc.add(DownloadEvent(artistsSelected));
                        }
                      : null,
                  label: "NEXT",
                )
              ]
            )
          )
        );
      }
    );
  }
}