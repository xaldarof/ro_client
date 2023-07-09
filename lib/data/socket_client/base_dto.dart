class BaseDTO {
  final String event;
  final String body;

  const BaseDTO({
    required this.event,
    required this.body,
  });

  Map<String, dynamic> toMap() {
    return {
      'event': event,
      'body': body,
    };
  }

  factory BaseDTO.fromMap(Map<String, dynamic> map) {
    return BaseDTO(
      event: map['event'] as String,
      body: map['body'] as String,
    );
  }
}
