import 'package:persian_datetime_picker/persian_datetime_picker.dart'
    show DateTimeExt, Jalali;
import 'package:pocketbase/pocketbase.dart' show RecordModel;

import 'category.dart';
import 'card.dart';

class Transaction {
  final String id;
  final String collectionId;
  final String collectionName;
  final DateTime created;
  final DateTime updated;
  final String user;
  final String description;
  final int amount;
  final Category category;
  final Card card;
  final Jalali date;

  Transaction({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.created,
    required this.updated,
    required this.user,
    required this.description,
    required this.amount,
    required this.category,
    required this.card,
    required this.date,
  });

  static Transaction get empty => Transaction(
        id: '',
        collectionId: '',
        collectionName: '',
        created: DateTime.now(),
        updated: DateTime.now(),
        user: '',
        description: '',
        amount: 0,
        category: Category.empty,
        card: Card.empty,
        date: Jalali.now(),
      );

  factory Transaction.fromRecord(RecordModel record) =>
      Transaction.fromJson(record.toJson());

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json['id'],
        collectionId: json['collectionId'],
        collectionName: json['collectionName'],
        created: DateTime.parse(json['created']),
        updated: DateTime.parse(json['updated']),
        user: json['user'],
        description: json['description'],
        amount: json['amount'],
        category: Category.fromJson(json['expand']['category']),
        card: Card.fromJson(json['expand']['card']),
        date: DateTime.parse(json['date']).toJalali(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'collectionId': collectionId,
        'collectionName': collectionName,
        'created': created.toIso8601String(),
        'updated': updated.toIso8601String(),
        'user': user,
        'description': description,
        'amount': amount,
        'category': category.toJson(),
        'card': card.toJson(),
        'date': date.toDateTime().toIso8601String(),
      };
}
