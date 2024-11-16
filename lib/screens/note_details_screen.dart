import 'package:flutter/material.dart';
import '../models/note_model.dart';

class NoteDetailsScreen extends StatelessWidget {
  final Note note;

  const NoteDetailsScreen({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () async {
              //await Clipboard.setData(ClipboardData(text: note.content));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Note content copied to clipboard')),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8.0),
            const Divider(),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  'note.content',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
