import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceRecord {
  AttendanceRecord({
    required this.id,
    required this.sessionId,
    required this.userId,
    required this.timestamp,
    required this.method,
    required this.userName,
    this.status = 'hadir',
  });

  final String id;
  final String sessionId;
  final String userId;
  final DateTime timestamp;
  final String method;
  final String status;
  final String userName;

  Map<String, dynamic> toMap() {
    return {
      'sessionId': sessionId,
      'userId': userId,
      'timestamp': Timestamp.fromDate(timestamp),
      'method': method,
      'status': status,
      'userName': userName,
    };
  }

  factory AttendanceRecord.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return AttendanceRecord(
      id: doc.id,
      sessionId: data['sessionId'] as String? ?? '',
      userId: data['userId'] as String? ?? '',
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
      method: data['method'] as String? ?? 'qr',
      status: data['status'] as String? ?? 'hadir',
      userName: data['userName'] as String? ?? '-',
    );
  }
}
