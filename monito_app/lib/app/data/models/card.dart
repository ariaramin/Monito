
import 'package:persian_datetime_picker/persian_datetime_picker.dart' show DateTimeExt, Jalali;
import 'package:pocketbase/pocketbase.dart' show RecordModel;

import 'bank.dart';

class Card {
  final String id;
  final String collectionId;
  final String collectionName;
  final DateTime created;
  final DateTime updated;
  final String user;
  final Bank? bank;
  final String title;
  final int number;
  final Jalali? expireDate;

  Card({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.created,
    required this.updated,
    required this.user,
    this.bank,
    required this.title,
    required this.number,
    this.expireDate,
  });

  static Card get empty => Card(
        id: '',
        collectionId: '',
        collectionName: '',
        created: DateTime.now(),
        updated: DateTime.now(),
        user: '',
        title: '',
        number: 0,
        expireDate: Jalali.now(),
      );

  factory Card.fromRecord(RecordModel record) => Card.fromJson(record.toJson());

  factory Card.fromJson(Map<String, dynamic> json) => Card(
        id: json['id'],
        collectionId: json['collectionId'],
        collectionName: json['collectionName'],
        created: DateTime.parse(json['created']),
        updated: DateTime.parse(json['updated']),
        user: json['user'],
        bank: Bank.fromJson(json['expand']['bank']),
        title: json['title'],
        number: json['number'],
        expireDate: (json['expire_date'] as String).isNotEmpty
            ? DateTime.parse(json['expire_date']).toJalali()
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'collectionId': collectionId,
        'collectionName': collectionName,
        'created': created.toIso8601String(),
        'updated': updated.toIso8601String(),
        'user': user,
        'bank': bank?.toJson(),
        'title': title,
        'number': number,
        'expire_date': expireDate?.toDateTime().toIso8601String(),
      };
}
