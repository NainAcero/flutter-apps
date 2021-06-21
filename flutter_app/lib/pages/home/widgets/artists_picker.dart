import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/home/bloc.dart';
import 'package:flutter_app/models/artist.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArtistsPicker  extends StatefulWidget {

  
  @override
  _ArtistsPickerState createState() => _ArtistsPickerState();
}

class _ArtistsPickerState extends State<ArtistsPicker> {
  
  @override
  Widget build(BuildContext context) {

    final bloc = HomeBloc.of(context);

    return BlocBuilder<HomeBloc, HomeState>(builder: (_, state) {

      final List<Artist> artists = state.artists
      .where(
        (element) => element.name
            .toLowerCase()
            .contains(state.searchText.toLowerCase()),
      )
      .toList();

      return SliverPadding(
        padding: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 10,
        ),
        sliver: SliverGrid(
          delegate: SliverChildBuilderDelegate((_, index) {
            final Artist artist = artists[index];
            return Column(
              children: <Widget>[
                Expanded(
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      bloc.add(OnSelectedEvent(artist.id));
                    },
                    child: ClipOval(
                      child: Stack(
                        children: <Widget>[
                          CachedNetworkImage(
                            imageUrl: artist.picture,
                            placeholder: (_, __) {
                              return CupertinoActivityIndicator();
                            },
                          ),
                          Positioned.fill(
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              color: artist.selected
                                ? Colors.black26
                                : Colors.transparent,
                              child: Icon(
                                Icons.check_circle,
                                color: artist.selected
                                  ? Colors.white
                                  : Colors.transparent
                              ),
                            )
                          )
                        ]
                      )
                    ),
                  )
                ),
                Text(artist.name),
              ]
            );
          },
          childCount: artists.length,
          ),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 130,
            mainAxisSpacing: 10,
            crossAxisSpacing: 20,
          )
        )
      );
    });
  }
}