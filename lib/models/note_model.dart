class Note {
  final int? id;
  final String title;
  final String content;
  final String category;
  final DateTime date;

  Note({
    this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.date,
  });

  // Method to create a copy of the object with updated fields
  Note copyWith({
    int? id,
    String? title,
    String? content,
    String? category,
    DateTime? date,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      category: category ?? this.category,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'category': category,
      'date': date.toIso8601String(),
    };
  }

  static Note fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as int?,
      title: map['title'] as String,
      content: map['content'] as String,
      category: map['category'] as String,
      date: DateTime.parse(map['date'] as String),
    );
  }
}
