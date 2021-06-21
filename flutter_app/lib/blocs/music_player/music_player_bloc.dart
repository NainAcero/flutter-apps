import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/libs/music_player.dart';
import 'package:flutter_app/models/artist.dart';
import 'package:flutter_app/models/track.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'music_player_events.dart';
import 'music_player_state.dart';

class MusicPlayerBloc extends Bloc<MusicPlayerEvent, MusicPlayerState> {

  final Artist artist;

  MusicPlayer _musicPlayer;

  MusicPlayer get musicPlayer => _musicPlayer;
  
  MusicPlayerBloc(this.artist) : super(MusicPlayerState.initialState()){
    _musicPlayer = MusicPlayer(
      onFinished: () {
        add(NextTrackEvent());
      }
    );
    _play();
    _play();
  }

  _play() {
    final int index = this.state.currentTrackIndex;
    final track = this.artist.tracks[index];
    _musicPlayer.play(track.preview);
  }

  @override
  Future<void> close() {
    _musicPlayer.dispose();
    return super.close();
  }

  @override
  MusicPlayerState get initialState => MusicPlayerState.initialState();

  @override
  Stream<MusicPlayerState> mapEventToState(MusicPlayerEvent event) async*{
    if (event is NextTrackEvent) {
      final index = this.state.currentTrackIndex + 1;
      if (index < artist.tracks.length) {
        yield this.state.copyWith(currentTrackIndex: index);
        _play();
      }
    } else if (event is PrevTrackEvent) {
      final index = this.state.currentTrackIndex - 1;
      if (index >= 0) {
        yield this.state.copyWith(currentTrackIndex: index);
        _play();
      }
    }
  }

  static MusicPlayerBloc of(BuildContext context) {
    return BlocProvider.of<MusicPlayerBloc>(context);
  }
}