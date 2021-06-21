import 'package:equatable/equatable.dart';
import 'package:flutter_simple_webrtc/models/heroe.dart';

enum Status { loading, showPicker, connected, calling, inCalling, inComming }

class AppState extends Equatable {

  final Status status;
  final Map<String, Heroe> heroes; 
  final Heroe? me, him;
  final bool isFrontCamera;
  final bool mute;
  
  AppState({
    this.status = Status.loading, 
    required this.heroes, 
    required this.me, 
    required this.him, 
    this.isFrontCamera = true,
    this.mute = false
  });

  static AppState get initialState => AppState(
    status: Status.loading,
    heroes: Map<String, Heroe>(),
    me: null,
    him: null,
  );

  AppState copyWith({
    Status? status,
    Map<String, Heroe>? heroes,
    Heroe? me,
    Heroe? him,
    bool? isFDrontCamera,
    bool? mute,
  }){
    return AppState(
      status: status ?? this.status,
      heroes: heroes ?? this.heroes,
      me: me ?? this.me,
      isFrontCamera: isFDrontCamera ?? this.isFrontCamera,
      mute: mute ?? this.mute,
      him: him ?? this.him,
    );
  }

  @override
  List<Object> get props => [
    status, heroes, isFrontCamera, mute
  ];
}