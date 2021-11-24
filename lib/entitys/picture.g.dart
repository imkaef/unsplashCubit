// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'picture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Picture _$PictureFromJson(Map<String, dynamic> json) => Picture(
      id: json['id'] as String,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      width: json['width'] as int?,
      height: json['height'] as int?,
      color: json['color'] as String?,
      blurHash: json['blur_hash'] as String?,
      altDescription: json['alt_description'] as String?,
      urls: json['urls'] == null
          ? null
          : Urls.fromJson(json['urls'] as Map<String, dynamic>),
      likes: json['likes'] as int?,
      likedByUser: json['liked_by_user'] as bool?,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PictureToJson(Picture instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'width': instance.width,
      'height': instance.height,
      'color': instance.color,
      'blur_hash': instance.blurHash,
      'alt_description': instance.altDescription,
      'urls': instance.urls?.toJson(),
      'likes': instance.likes,
      'liked_by_user': instance.likedByUser,
      'user': instance.user.toJson(),
    };

Urls _$UrlsFromJson(Map<String, dynamic> json) => Urls(
      raw: json['raw'] as String,
      full: json['full'] as String,
      regular: json['regular'] as String,
      small: json['small'] as String,
      thumb: json['thumb'] as String,
    );

Map<String, dynamic> _$UrlsToJson(Urls instance) => <String, dynamic>{
      'raw': instance.raw,
      'full': instance.full,
      'regular': instance.regular,
      'small': instance.small,
      'thumb': instance.thumb,
    };

ProfileImage _$ProfileImageFromJson(Map<String, dynamic> json) => ProfileImage(
      small: json['small'] as String,
      medium: json['medium'] as String,
      large: json['large'] as String,
    );

Map<String, dynamic> _$ProfileImageToJson(ProfileImage instance) =>
    <String, dynamic>{
      'small': instance.small,
      'medium': instance.medium,
      'large': instance.large,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      updatedAt: json['updated_at'] as String?,
      username: json['username'] as String?,
      name: json['name'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      portfolioUrl: json['portfolio_url'] as String?,
      bio: json['bio'] as String?,
      profileImage: json['profile_image'] == null
          ? null
          : ProfileImage.fromJson(
              json['profile_image'] as Map<String, dynamic>),
      totalCollections: json['total_collections'] as int?,
      totalLikes: json['total_likes'] as int?,
      totalPhotos: json['total_photos'] as int?,
      acceptedTos: json['accepted_tos'] as bool?,
      forHire: json['for_hire'] as bool?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'updated_at': instance.updatedAt,
      'username': instance.username,
      'name': instance.name,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'portfolio_url': instance.portfolioUrl,
      'bio': instance.bio,
      'profile_image': instance.profileImage?.toJson(),
      'total_collections': instance.totalCollections,
      'total_likes': instance.totalLikes,
      'total_photos': instance.totalPhotos,
      'accepted_tos': instance.acceptedTos,
      'for_hire': instance.forHire,
    };
