class AnalyticsEvent {
  final String id;
  final String? userId;
  final String eventType;
  final String eventAction;
  final Map<String, dynamic> eventData;
  final DateTime timestamp;

  AnalyticsEvent({
    required this.id,
    this.userId,
    required this.eventType,
    required this.eventAction,
    this.eventData = const {},
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'eventType': eventType,
    'eventAction': eventAction,
    'eventData': eventData,
    'timestamp': timestamp.toIso8601String(),
  };

  factory AnalyticsEvent.fromJson(Map<String, dynamic> json) {
    DateTime parsedDate = DateTime.now();
    if (json['timestamp'] != null) {
      if (json['timestamp'] is String) {
        parsedDate = DateTime.tryParse(json['timestamp']) ?? DateTime.now();
      } else if (json['timestamp'].runtimeType.toString() == 'Timestamp') {
        parsedDate = json['timestamp'].toDate();
      }
    }

    return AnalyticsEvent(
      id: json['id'] ?? '',
      userId: json['userId'],
      eventType: json['eventType'] ?? 'unknown',
      eventAction: json['eventAction'] ?? 'unknown',
      eventData: json['eventData'] != null ? Map<String, dynamic>.from(json['eventData']) : {},
      timestamp: parsedDate,
    );
  }
}
