
import 'package:flutter_simple_webrtc/blocs/bloc.dart';
import 'package:flutter_simple_webrtc/models/heroe.dart';

abstract class AppStateEvent {}

class LoadingEvent extends AppStateEvent {}

class ShowPickerEvent extends AppStateEvent {
  final Map<String, Heroe> heroes;

  ShowPickerEvent(this.heroes);
}

class PickHeroEvent extends AppStateEvent{
  final String heroName;

  PickHeroEvent(this.heroName);
}

class ConnectedEvent extends AppStateEvent {
  final Heroe hero;

  ConnectedEvent(this.hero);
}

class TakenEvent extends AppStateEvent{
  final String heroName;
  final bool isTaken;

  TakenEvent({ 
    required this.heroName,
    required this.isTaken
  });
}

class CallingEvent extends AppStateEvent {
  final Heroe hero;

  CallingEvent(this.hero);
}

class InCallingEvent extends AppStateEvent { }

class IncommingEvent extends AppStateEvent {
  final String heroName;

  IncommingEvent(this.heroName);
}

class AcceptOrDeclineEvent extends AppStateEvent {
  final bool accept;

  AcceptOrDeclineEvent(this.accept);
}

class CancelRequestEvent extends AppStateEvent { }

class FinishCallEvent extends AppStateEvent { }

class SwitchCameraEvent extends AppStateEvent {
  final bool isFDrontCamera;

  SwitchCameraEvent(this.isFDrontCamera);
}

class MuteEvent extends AppStateEvent {
  final bool mute;

  MuteEvent(this.mute);
}