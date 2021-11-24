import 'package:json_annotation/json_annotation.dart';

part 'picture.g.dart';

@JsonSerializable(explicitToJson: true,fieldRename: FieldRename.snake)
class Picture {
  final String id;
  final String? createdAt;
  final String? updatedAt;
  final int? width;
  final int? height;
  final String? color;
  final String? blurHash;
  final String? altDescription;
  final Urls? urls;
  final int? likes;
  final bool? likedByUser;
  final User user;
  Picture({
    required this.id,
    this.createdAt,
    this.updatedAt,
    this.width,
    this.height,
    this.color,
    this.blurHash,
    this.altDescription,
    this.urls,
    this.likes,
    this.likedByUser,
    required this.user,
  });

  factory Picture.fromJson(Map<String, dynamic> json) =>
      _$PictureFromJson(json);
  Map<String, dynamic> toJson() => _$PictureToJson(this);
}

@JsonSerializable(explicitToJson: true,fieldRename: FieldRename.snake)
class Urls {
  final String raw;
  final String full;
  final String regular;
  final String small;
  final String thumb;
  Urls({
    required this.raw,
    required this.full,
    required this.regular,
    required this.small,
    required this.thumb,
  });
  factory Urls.fromJson(Map<String, dynamic> json) => _$UrlsFromJson(json);
  Map<String, dynamic> toJson() => _$UrlsToJson(this);
}

@JsonSerializable(explicitToJson: true,fieldRename: FieldRename.snake)
class ProfileImage {
  final String small;
  final String medium;
  final String large;
  ProfileImage({
    required this.small,
    required this.medium,
    required this.large,
  });
  factory ProfileImage.fromJson(Map<String, dynamic> json) =>
      _$ProfileImageFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileImageToJson(this);
}

@JsonSerializable(explicitToJson: true,fieldRename: FieldRename.snake)
class User {
  final String id;
  final String? updatedAt;
  final String? username;
  final String? name;
  final String? firstName;
  final String? lastName;
  final String? portfolioUrl;
  final String? bio;

  final ProfileImage? profileImage;

  final int? totalCollections;
  final int? totalLikes;
  final int? totalPhotos;
  final bool? acceptedTos;
  final bool? forHire;

  User({
    required this.id,
    this.updatedAt,
    this.username,
    this.name,
    this.firstName,
    this.lastName,
    this.portfolioUrl,
    this.bio,
    this.profileImage,
    this.totalCollections,
    this.totalLikes,
    this.totalPhotos,
    this.acceptedTos,
    this.forHire,
  });
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
