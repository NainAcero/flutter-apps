import 'package:flutter_app/models/artist.dart';

abstract class HomeEvent {}

class CheckDbEvent extends HomeEvent {}

class LoadArtistsEvent extends HomeEvent {}

class OnSelectArtistEvent extends HomeEvent {}

class OnSearchEvent extends HomeEvent {
  final String searchText;
  OnSearchEvent(this.searchText);
}

class DownloadEvent extends HomeEvent {
  final List<Artist> artistsSelected;
  
  DownloadEvent(this.artistsSelected);
}

class OnSelectedEvent extends HomeEvent{
  final int id;

  OnSelectedEvent(this.id);

}