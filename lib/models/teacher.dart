import 'package:cloud_firestore/cloud_firestore.dart';

class Teacher {
  Teacher({
    required this.id,
    required this.name,
    this.topic,
    this.notes,
    this.createdBy,
  });

  final String id;
  final String name;
  final String? topic;
  final String? notes;
  final String? createdBy;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'topic': topic,
      'notes': notes,
      'createdBy': createdBy,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  factory Teacher.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return Teacher(
      id: doc.id,
      name: data['name'] as String? ?? 'Ustadz',
      topic: data['topic'] as String?,
      notes: data['notes'] as String?,
      createdBy: data['createdBy'] as String?,
    );
  }
}
