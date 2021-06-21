import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_webrtc/blocs/app_state.dart';
import 'package:flutter_simple_webrtc/blocs/app_state_events.dart';
import 'package:flutter_simple_webrtc/libs/signaling.dart';
import 'package:flutter_simple_webrtc/models/heroe.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class AppStateBloc extends Bloc<AppStateEvent, AppState>{

  AppStateBloc() : super(AppState.initialState) {
    _init();
  }

  @override
  AppState get initialState => AppState.initialState;

  Signaling _signaling = Signaling();
  late RTCVideoRenderer _localRender = RTCVideoRenderer();
  late RTCVideoRenderer _remoteRender = RTCVideoRenderer();

  RTCVideoRenderer get localRender => _localRender;
  RTCVideoRenderer get remoteRender => _remoteRender;

  _init() async{
   await _localRender.initialize();
   await _remoteRender.initialize();

    _signaling.init();

    _signaling.onLocalStream = (MediaStream stream) {
      _localRender.srcObject = stream;
    };

     _signaling.onRemoteStream = (MediaStream stream) {
       _remoteRender.srcObject = stream;
    };

    _signaling.onConnected = ( Map<String, Heroe> heroes) {
      add(ShowPickerEvent(heroes));
    };

    _signaling.onAssigned = (String? heroName) {
      if(heroName == null){
        add(ShowPickerEvent(state.heroes));
      }else{
        final myHero =  state.heroes[heroName];
        add(ConnectedEvent(myHero!));
      }
    };

    _signaling.onTaken = (String heroName) {
      add(TakenEvent(heroName: heroName, isTaken: true));
    };

    _signaling.onDisconnected = (String heroName) {
      add(TakenEvent(heroName: heroName, isTaken: false));
    };

    _signaling.onCancelRequest = () {
      add(ConnectedEvent(state.me!));
    };

    _signaling.onFinishCall = () {
      add(ConnectedEvent(state.me!));
    };

    _signaling.onResponse = (dynamic answer) {
      if(answer != null){
        add(InCallingEvent());
      } else{
        add(ConnectedEvent(state.me!));
      }
    };

    _signaling.onRequest = (dynamic data) {
      add(IncommingEvent(data['superHeroName']));
    };
  }

  @override
  Future<void> close() {
    _localRender.dispose();
    _remoteRender.dispose();
    _signaling.dispose();
    return super.close();
  }

  @override
  Stream<AppState> mapEventToState(AppStateEvent event) async*{

    if(event is ShowPickerEvent){
      yield this.state.copyWith(status: Status.showPicker, heroes: event.heroes);
    } else if(event is PickHeroEvent) {
      _signaling.emit('pick', event.heroName);
      yield this.state.copyWith(status: Status.loading);
    } else if(event is ConnectedEvent){
      yield this.state.copyWith(status: Status.connected, me: event.hero, him: null, mute: false);
    } else if(event is TakenEvent) {
      Map<String, Heroe> newHeroes = Map();
      newHeroes.addAll(state.heroes);
      final heroTaken = newHeroes[event.heroName]!.copyWith(isTaken: event.isTaken);
      newHeroes[heroTaken.name] = heroTaken;
      yield state.copyWith(heroes: newHeroes);
    } else if(event is CallingEvent) {
      _signaling.callTo(event.hero.name);
      yield state.copyWith(status: Status.calling, him: event.hero);
    } else if(event is InCallingEvent){
      yield state.copyWith(status: Status.inCalling);
    } else if(event is IncommingEvent) {
      final him = state.heroes[event.heroName];
      yield state.copyWith(status: Status.inComming, him: him);
    } else if(event is AcceptOrDeclineEvent){
      if(event.accept) {
        await _signaling.acceptOrDecline(true);
        yield state.copyWith(status: Status.inCalling);
      }else {
        await _signaling.acceptOrDecline(false);
        yield state.copyWith(status: Status.connected, him: null);
      }
    } else if(event is CancelRequestEvent) {
      _signaling.cancelRequest();
      yield state.copyWith(status: Status.connected, him: null);
    }else if(event is FinishCallEvent) {
      _signaling.finishCurrentCall();
      yield state.copyWith(status: Status.connected, him: null, isFDrontCamera: true);
    }else if(event is SwitchCameraEvent) {
      _signaling.changeCamera();
      yield state.copyWith(isFDrontCamera: event.isFDrontCamera);
    }else if(event is MuteEvent){
      _signaling.setMicrophoneMute(event.mute);
      yield state.copyWith(mute: event.mute);
    }
  }

  static AppStateBloc of(BuildContext context) {
    return BlocProvider.of<AppStateBloc>(context);
  }
  
}