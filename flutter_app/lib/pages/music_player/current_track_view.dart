import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/music_player/bloc.dart';
import 'package:flutter_app/models/track.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentTrackView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final MusicPlayerBloc bloc = MusicPlayerBloc.of(context);

    return Container(
      child: BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
        builder: (_, state) {
          final Track currentTrack =
              bloc.artist.tracks[state.currentTrackIndex];
          return Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 16 / 14.5,
                child: ClipPath(
                  clipper: _AlbumClipper(),
                  child: Container(
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: CachedNetworkImage(
                            imageUrl: currentTrack.album.cover,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        )
                      ]
                    )
                  )
                )
              ),
              Text(
                currentTrack.album.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                currentTrack.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "${state.currentTrackIndex + 1} / ${bloc.artist.tracks.length}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w100,
                ),
              ),
              SizedBox(height: 10),
            ]
          );
        }
      )
    );
  }
}

class _AlbumClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    path.arcToPoint(Offset(size.width, size.height),
        radius: Radius.circular(size.width));
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}