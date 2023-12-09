import 'package:equatable/equatable.dart';

class UserInfoEntity extends Equatable {
  final AvatarEntity? avatar;
  final int? id;
  final String? iso6391;
  final String? iso31661;
  final String? name;
  final bool? includeAdult;
  final String? username;

  const UserInfoEntity({
    this.avatar,
    this.id,
    this.iso6391,
    this.iso31661,
    this.name,
    this.includeAdult,
    this.username,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        avatar,
        id,
        iso6391,
        iso31661,
        name,
        includeAdult,
        username,
      ];
}

class AvatarEntity extends Equatable {
  final GravatarEntity? gravatar;
  final TmdbEntity? tmdb;

  const AvatarEntity({
    this.gravatar,
    this.tmdb,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        gravatar,
        tmdb,
      ];
}

class GravatarEntity extends Equatable {
  final String? hash;

  const GravatarEntity({
    this.hash,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        hash,
      ];
}

class TmdbEntity extends Equatable {
  final dynamic avatarPath;

  const TmdbEntity({
    this.avatarPath,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [avatarPath];
}
