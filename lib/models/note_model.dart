class Note {
  final int? id;
  final String title;
  final String content;
  final DateTime date;
  final int? color; // Color field (integer)

  Note({
    this.id,
    required this.title,
    required this.content,
    required this.date,
    this.color,
  });

  // Convert Note to Map for database insertion
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date': date.toIso8601String(),
      'color': color,  // Save color as integer
    };
  }

  // Create Note object from Map
  static Note fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      date: DateTime.parse(map['date']),
      color: map['color'],  // Retrieve color as integer
    );
  }

  // Copy Note with modified id (for updates)
  Note copyWith({
    int? id,
    String? title,
    String? content,
    DateTime? date,
    int? color,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      date: date ?? this.date,
      color: color ?? this.color,
    );
  }
}
