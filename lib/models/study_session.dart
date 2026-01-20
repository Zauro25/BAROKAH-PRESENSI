import 'package:cloud_firestore/cloud_firestore.dart';

class StudySession {
  StudySession({
    required this.id,
    required this.title,
    required this.location,
    required this.teacherName,
    required this.scheduledAt,
    required this.createdBy,
    this.description,
    this.qrCode,
  });

  final String id;
  final String title;
  final String location;
  final String teacherName;
  final DateTime scheduledAt;
  final String createdBy;
  final String? description;
  final String? qrCode;

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'location': location,
      'teacherName': teacherName,
      'scheduledAt': Timestamp.fromDate(scheduledAt),
      'createdBy': createdBy,
      'description': description,
      'qrCode': qrCode ?? id,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  factory StudySession.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return StudySession(
      id: doc.id,
      title: data['title'] as String? ?? 'Sesi Kajian',
      location: data['location'] as String? ?? '-',
      teacherName: data['teacherName'] as String? ?? '-',
      scheduledAt: (data['scheduledAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      createdBy: data['createdBy'] as String? ?? '',
      description: data['description'] as String?,
      qrCode: data['qrCode'] as String?,
    );
  }
}
