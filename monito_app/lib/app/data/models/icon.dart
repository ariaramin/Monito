import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pocketbase/pocketbase.dart' show RecordModel;

class Icon {
  final String? id;
  final String? collectionId;
  final String? collectionName;
  final DateTime? created;
  final DateTime? updated;
  final String icon;

  Icon({
    this.id,
    this.collectionId,
    this.collectionName,
    this.created,
    this.updated,
    required this.icon,
  });

  factory Icon.fromRecord(RecordModel record) => Icon.fromJson(record.toJson());

  factory Icon.fromJson(Map<String, dynamic> json) => Icon(
        id: json['id'],
        collectionId: json['collectionId'],
        collectionName: json['collectionName'],
        created: DateTime.parse(json['created']),
        updated: DateTime.parse(json['updated']),
        icon:
            '${dotenv.env['API_URL']!}/api/files/${json['collectionId']}/${json['id']}/${json['icon']}',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'collectionId': collectionId,
        'collectionName': collectionName,
        'created': created?.toIso8601String(),
        'updated': updated?.toIso8601String(),
        'icon': icon,
      };
}
