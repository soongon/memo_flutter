import 'package:uuid/uuid.dart';

class Memo {
  final String id;
  final String text;
  final DateTime createdAt;

  Memo({
    String? id,
    required this.text,
    DateTime? createdAt,
  }) : id = id ?? const Uuid().v4(),
       createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Memo.fromMap(Map<String, dynamic> map) {
    return Memo(
      id: map['id'],
      text: map['text'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}