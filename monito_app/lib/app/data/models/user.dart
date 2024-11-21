import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pocketbase/pocketbase.dart' show RecordModel;

class User {
  final String collectionId;
  final String id;
  final String avatar;
  final String name;
  final String email;
  final String created;
  final String updated;

  User({
    required this.collectionId,
    required this.id,
    required this.avatar,
    required this.name,
    required this.email,
    required this.created,
    required this.updated,
  });

  factory User.fromRecord(RecordModel record) => User.fromJson(record.toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        collectionId: json['collectionId'],
        id: json['id'],
        avatar: (json['avatar'] as String).isEmpty
            ? 'https://img.myloview.com/stickers/default-avatar-profile-icon-vector-social-media-user-symbol-image-400-244492311.jpg'
            : '${dotenv.env['API_URL']!}/api/files/${json['collectionId']}/${json['id']}/${json['avatar']}',
        name: json['name'],
        email: json['email'],
        created: json['created'],
        updated: json['updated'],
      );


  RecordModel toModel() => RecordModel(
    collectionId: collectionId,
    collectionName: 'users',
    id: id,
    data: toJson(),
    expand: {},
    created: created,
    updated: updated,
  );

  Map<String, dynamic> toJson() => {
        'collectionId': collectionId,
        'id': id,
        'avatar': avatar,
        'name': name,
        'email': email,
        'created': created,
        'updated': updated,
      };

  static final empty = User(
    collectionId: '',
    id: '',
    avatar: '',
    email: '',
    name: '',
    created: '',
    updated: '',
  );

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;
}
