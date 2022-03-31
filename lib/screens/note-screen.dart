import 'package:flutter/material.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/providers/note-collection.dart';
import 'package:provider/provider.dart';

class NoteScreen extends StatefulWidget {
  final Note note;
  const NoteScreen({Key? key, required this.note}) : super(key: key);


  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {

  final TextEditingController bodyController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bodyController.text = widget.note.noteBody;
    titleController.text = widget.note.title;

    bodyController.addListener(() {
      Provider.of<NoteCollection>(context, listen: false).updateNote(widget.note.id, bodyController.text);
    });

    titleController.addListener(() {
      Provider.of<NoteCollection>(context, listen: false).updateTitle(widget.note.id, titleController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.grey,
            onPressed: () {
              Provider.of<NoteCollection>(context, listen: false).removeIfEmpty(widget.note);
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Column(
          children:  [
            TextField(
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
              controller: titleController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  hintText: 'Write Title',
                  hintStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20)
              ),
            ),
            const SizedBox(height: 10,),
            Expanded(
              child: TextField(
                controller: bodyController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(
                    hintText: 'Start writing your note here',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20)
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              color: Colors.red,
              child: Consumer<NoteCollection>(
                builder: (context, notes, child) {
                  var currentNote = widget.note;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${currentNote.charCount} chars count'),
                      Text('${currentNote.wordCount} word count')
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}