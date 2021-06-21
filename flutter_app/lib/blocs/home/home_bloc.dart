import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/api/deezer_api.dart';
import 'package:flutter_app/db/artists_store.dart';
import 'package:flutter_app/models/artist.dart';
import 'package:flutter_app/models/track.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_events.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  HomeBloc() : super(HomeState.initialState) {
    add(CheckDbEvent());
  }

  @override
  HomeState get initialState => HomeState.initialState;

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async*{
    if(event is CheckDbEvent) {
      yield* this._mapCheckDb(event);
    } else if (event is OnSearchEvent) {
      yield this.state.copyWith(searchText: event.searchText);
    } else if (event is OnSelectedEvent) {
      yield* this._mapOnSelected(event);
    } else if (event is DownloadEvent) {
      yield* this._mapDownloadTracks(event);
    }
  }

  Stream<HomeState> _mapDownloadTracks(DownloadEvent event) async* {
    yield this.state.copyWith(status: HomeStatus.downloading);

    List<Artist> artists = [];

    for (final Artist artist in event.artistsSelected) {
      final List<Track> tracks = await DeezerAPI.instance.getTracks(artist.id);
      print("artist ${artist.id} tracks : ${tracks.length}");
      artists.add(artist.addTracks(tracks));
    }

    await ArtistsStore.instance.addAll(artists);
    yield this.state.copyWith(status: HomeStatus.ready, artists: artists);
  }

  Stream<HomeState> _mapOnSelected(OnSelectedEvent event) async* {
    final int id = event.id;
    final List<Artist> tmp = List<Artist>.from(this.state.artists);
    final int index = tmp.indexWhere((element) => element.id == id);
    if (index != -1) {
      tmp[index] = tmp[index].onSelected();
      yield this.state.copyWith(artists: tmp);
    }

  }

  Stream<HomeState> _mapCheckDb(CheckDbEvent event) async* {

    final List<Artist> artists = await ArtistsStore.instance.find();

    if (artists != null && artists.length >= 5) {
      yield this.state.copyWith(status: HomeStatus.ready, artists: artists);
    } else {

      yield this.state.copyWith(status: HomeStatus.loading);

      final List<Artist> artists = await DeezerAPI.instance.getArtist();
      if (artists != null) {
        print("artists ${artists.length}");

        yield this.state.copyWith(
          status: HomeStatus.selecting,
          artists: artists,
        );
      } else {
        yield this.state.copyWith(status: HomeStatus.error);
      }
    }
  }

  static HomeBloc of(BuildContext context) {
    return BlocProvider.of<HomeBloc>(context);
  }
}