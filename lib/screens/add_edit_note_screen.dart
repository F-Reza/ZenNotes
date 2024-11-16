import 'package:flutter/material.dart';
import '../models/note_model.dart';
import '../db/notes_database.dart';

class AddEditNoteScreen extends StatefulWidget {
  final Note? note;

  const AddEditNoteScreen({Key? key, this.note}) : super(key: key);

  @override
  _AddEditNoteScreenState createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  int? _selectedColor; // Variable to hold selected color

  // Define a list of colors for the rectangular boxes
  final List<Map<String, dynamic>> _colorOptions = [
    {'name': 'Red', 'value': Colors.red.value, 'color': Colors.red},
    {'name': 'Blue', 'value': Colors.blue.value, 'color': Colors.blue},
    {'name': 'Green', 'value': Colors.green.value, 'color': Colors.green},
    {'name': 'Yellow', 'value': Colors.yellow.value, 'color': Colors.yellow},
    {'name': 'Purple', 'value': Colors.purple.value, 'color': Colors.purple},
    {'name': 'Orange', 'value': Colors.orange.value, 'color': Colors.orange},
  ];

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
      _selectedColor = widget.note!.color; // Set the selected color
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _saveNote() async {
    if (_formKey.currentState!.validate()) {
      final isEditing = widget.note != null;

      final newNote = Note(
        id: isEditing ? widget.note!.id : null,
        title: _titleController.text,
        content: _contentController.text,
        date: DateTime.now(),
        color: _selectedColor, // Save selected color
      );

      if (isEditing) {
        await NotesDatabase.instance.update(newNote);
      } else {
        await NotesDatabase.instance.create(newNote);
      }

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'Add Note' : 'Edit Note'),
        actions: [
          if (widget.note != null)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                await NotesDatabase.instance.delete(widget.note!.id!);
                Navigator.pop(context, true);
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                decoration: const InputDecoration(
                  filled: true,
                  border: InputBorder.none,
                  labelText: 'Title',
                ),
                validator: (value) =>
                value == null || value.isEmpty ? 'Title is required' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _contentController,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  labelText: 'Content',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 0.3,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.black),
                  ),
                ),
                minLines: 20,
                maxLines: null,
                validator: (value) => value == null || value.isEmpty
                    ? 'Content is required'
                    : null,
              ),
              const SizedBox(height: 20),
              // Row of color selection boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _colorOptions.map((colorOption) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedColor = colorOption['value'];
                      });
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: colorOption['color'],
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: _selectedColor == colorOption['value']
                              ? Colors.black
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2d38ff),
                ),
                onPressed: _saveNote,
                child: Text(widget.note == null ? 'Create Note' : 'Save Changes',
                    style: const TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
