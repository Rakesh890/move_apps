import 'package:equatable/equatable.dart';
import 'package:movie_app/domain/entity/user_info_entity.dart';

class UserInfoModel extends UserInfoEntity with EquatableMixin {
  @override
  final Avatar? avatar;
  @override
  final int? id;
  @override
  final String? iso6391;
  @override
  final String? iso31661;
  @override
  final String? name;
  @override
  final bool? includeAdult;
  @override
  final String? username;

  UserInfoModel({
    this.avatar,
    this.id,
    this.iso6391,
    this.iso31661,
    this.name,
    this.includeAdult,
    this.username,
  });

  UserInfoModel.fromJson(Map<String, dynamic> json)
      : avatar = (json['avatar'] as Map<String, dynamic>?) != null
            ? Avatar.fromJson(json['avatar'] as Map<String, dynamic>)
            : null,
        id = json['id'] as int?,
        iso6391 = json['iso_639_1'] as String?,
        iso31661 = json['iso_3166_1'] as String?,
        name = json['name'] as String?,
        includeAdult = json['include_adult'] as bool?,
        username = json['username'] as String?;

  Map<String, dynamic> toJson() => {
        'avatar': avatar?.toJson(),
        'id': id,
        'iso_639_1': iso6391,
        'iso_3166_1': iso31661,
        'name': name,
        'include_adult': includeAdult,
        'username': username
      };
}

class Avatar extends AvatarEntity with EquatableMixin {
  @override
  final Gravatar? gravatar;
  @override
  final Tmdb? tmdb;

  Avatar({
    this.gravatar,
    this.tmdb,
  });

  Avatar.fromJson(Map<String, dynamic> json)
      : gravatar = (json['gravatar'] as Map<String, dynamic>?) != null
            ? Gravatar.fromJson(json['gravatar'] as Map<String, dynamic>)
            : null,
        tmdb = (json['tmdb'] as Map<String, dynamic>?) != null
            ? Tmdb.fromJson(json['tmdb'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() =>
      {'gravatar': gravatar?.toJson(), 'tmdb': tmdb?.toJson()};
}

class Gravatar extends GravatarEntity with EquatableMixin {
  @override
  final String? hash;

  Gravatar({
    this.hash,
  });

  Gravatar.fromJson(Map<String, dynamic> json) : hash = json['hash'] as String?;

  Map<String, dynamic> toJson() => {'hash': hash};
}

class Tmdb extends TmdbEntity with EquatableMixin {
  @override
  final dynamic avatarPath;

  Tmdb({
    this.avatarPath,
  });

  Tmdb.fromJson(Map<String, dynamic> json) : avatarPath = json['avatar_path'];

  Map<String, dynamic> toJson() => {'avatar_path': avatarPath};
}
