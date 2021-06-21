
import 'package:equatable/equatable.dart';

class Heroe extends Equatable{
  final String name, avatar;
  final bool isTaken;

  Heroe({
    required this.name,
    required this.avatar,
    required this.isTaken
  });

  factory Heroe.fromJson(dynamic json) => Heroe(
    name: json['name'],
    avatar: json['avatar'],
    isTaken: json['isTaken']
  );

  Heroe copyWith({ String? name, String? avatar, bool? isTaken}) {
    return Heroe(
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      isTaken: isTaken ?? this.isTaken);
  }

  @override
  List<Object> get props => [name, avatar, isTaken];
}