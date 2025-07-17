import 'package:crud_rumah_sakit/model/note.dart';
import 'package:crud_rumah_sakit/pages/note_editor_screen.dart';
import 'package:crud_rumah_sakit/pages/note_tile.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> notes = [];

  void addNote(Note note) => setState(() => notes.add(note));

  void editNote(int index, Note note) => setState(() => notes[index] = note);

  void deleteNote(int index) => setState(() => notes.removeAt(index));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MoodNotes"),
        centerTitle: true,
      ),
      body: notes.isEmpty
          ? Center(child: Text("Belum ada catatan 😶"))
          : Padding(
        padding: EdgeInsets.all(8),
        child: GridView.builder(
          itemCount: notes.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (_, i) => NoteTile(
            note: notes[i],
            onTap: () async {
              var updated = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => NoteEditorScreen(
                    note: notes[i],
                  ),
                ),
              );
              if (updated != null) editNote(i, updated);
            },
            onDelete: () => deleteNote(i),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          var result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => NoteEditorScreen()),
          );
          if (result != null) addNote(result);
        },
        label: Text("Note ✍️"),
      ),
    );
  }
}
