
import 'package:equatable/equatable.dart';
import 'package:flutter_app/blocs/music_player/bloc.dart';
import 'package:meta/meta.dart' show required;

class MusicPlayerState extends Equatable {
  final int currentTrackIndex;

  MusicPlayerState({
    @required this.currentTrackIndex
  });

  static MusicPlayerState initialState() {
    return MusicPlayerState(currentTrackIndex: 0);
  }

  MusicPlayerState copyWith({int currentTrackIndex}) {
    return MusicPlayerState(
      currentTrackIndex: currentTrackIndex ?? this.currentTrackIndex,
    );
  }

  @override
  List<Object> get props => [
    currentTrackIndex,
  ];

}