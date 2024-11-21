import 'package:pocketbase/pocketbase.dart' show RecordModel;

import 'icon.dart';

enum CategoryType { income, expense }

class Category {
  final String id;
  final String collectionId;
  final String collectionName;
  final DateTime created;
  final DateTime updated;
  final Icon icon;
  final String title;
  final String description;
  final CategoryType type;

  Category({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.created,
    required this.updated,
    required this.icon,
    required this.title,
    required this.description,
    required this.type,
  });

  static Category get empty => Category(
        id: '',
        collectionId: '',
        collectionName: '',
        created: DateTime.now(),
        updated: DateTime.now(),
        icon: Icon(icon: ''),
        title: '',
        description: '',
        type: CategoryType.expense,
      );

  factory Category.fromRecord(RecordModel record) =>
      Category.fromJson(record.toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'],
        collectionId: json['collectionId'],
        collectionName: json['collectionName'],
        created: DateTime.parse(json['created']),
        updated: DateTime.parse(json['updated']),
        icon: Icon.fromJson(json['expand']['icon']),
        title: json['title'],
        description: json['description'],
        type: _getTypeEnum(json['type']),
      );

  static CategoryType _getTypeEnum(String type) {
    switch (type) {
      case 'income':
        return CategoryType.income;
      default:
        return CategoryType.expense;
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'collectionId': collectionId,
        'collectionName': collectionName,
        'created': created.toIso8601String(),
        'updated': updated.toIso8601String(),
        'icon': icon.toJson(),
        'title': title,
        'description': description,
        'type': type.name,
      };
}
