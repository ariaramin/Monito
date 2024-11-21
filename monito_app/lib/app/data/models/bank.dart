import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pocketbase/pocketbase.dart' show RecordModel;

class Bank {
  final String? id;
  final String? collectionId;
  final String? collectionName;
  final DateTime? created;
  final DateTime? updated;
  final String icon;
  final String name;

  Bank({
    this.id,
    this.collectionId,
    this.collectionName,
    this.created,
    this.updated,
    required this.icon,
    required this.name,
  });

  static Bank get empty => Bank(icon: '', name: '');

  factory Bank.fromRecord(RecordModel record) => Bank.fromJson(record.toJson());

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        id: json['id'],
        collectionId: json['collectionId'],
        collectionName: json['collectionName'],
        created: DateTime.parse(json['created']),
        updated: DateTime.parse(json['updated']),
        icon: (json['icon'] as String).isNotEmpty
            ? '${dotenv.env['API_URL']!}/api/files/${json['collectionId']}/${json['id']}/${json['icon']}'
            : '',
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'collectionId': collectionId,
        'collectionName': collectionName,
        'created': created?.toIso8601String(),
        'updated': updated?.toIso8601String(),
        'icon': icon,
        'name': name,
      };
}
