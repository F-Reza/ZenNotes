import 'package:flutter/material.dart';
import '../models/note_model.dart';

class NoteCard extends StatelessWidget {
  final Note note;

  const NoteCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    // Use the color or fallback to blue if null
    final Color noteColor = note.color != null ? Color(note.color!) : Colors.grey;

    return Container(
      width: double.infinity, // This ensures the card takes full available width
      padding: const EdgeInsets.all(2),
      child: Card(
        color: noteColor, // Use the determined color
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10), // Adjust the inner padding as needed
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                note.content,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
                softWrap: true,
                maxLines: 7,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
