import 'package:crud_rumah_sakit/model/note.dart';
import 'package:flutter/material.dart';


class NoteTile extends StatelessWidget {
  final Note note;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const NoteTile({required this.note, required this.onTap, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: note.bgColor,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(note.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 8),
                  Text(note.content, maxLines: 4, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            Positioned(
              top: 4,
              right: 4,
              child: IconButton(onPressed: onDelete, icon: Icon(Icons.delete, size: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
