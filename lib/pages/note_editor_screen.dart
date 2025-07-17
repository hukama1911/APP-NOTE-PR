import 'package:crud_rumah_sakit/model/note.dart';
import 'package:crud_rumah_sakit/pages/colors.dart';
import 'package:flutter/material.dart';


class NoteEditorScreen extends StatefulWidget {
  final Note? note;

  const NoteEditorScreen({this.note});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  final titleCtrl = TextEditingController();
  final contentCtrl = TextEditingController();
  late Color selectedColor;

  @override
  void initState() {
    super.initState();
    titleCtrl.text = widget.note?.title ?? '';
    contentCtrl.text = widget.note?.content ?? '';
    selectedColor = widget.note?.bgColor ?? noteColors[0];
  }

  void save() {
    if (titleCtrl.text.isNotEmpty && contentCtrl.text.isNotEmpty) {
      final newNote = Note(
        title: titleCtrl.text,
        content: contentCtrl.text,
        bgColor: selectedColor,
      );
      Navigator.pop(context, newNote);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? "New Note" : "Edit Note"),
        actions: [
          IconButton(onPressed: save, icon: Icon(Icons.check)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: noteColors
                  .map((c) => GestureDetector(
                onTap: () => setState(() => selectedColor = c),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: c,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey),
                  ),
                  child: c == selectedColor ? Icon(Icons.check, size: 18) : null,
                ),
              ))
                  .toList(),
            ),
            SizedBox(height: 20),
            TextField(
              controller: titleCtrl,
              decoration: InputDecoration(labelText: "Judul Catatan"),
            ),
            SizedBox(height: 10),
            Expanded(
              child: TextField(
                controller: contentCtrl,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(labelText: "Isi catatan"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
