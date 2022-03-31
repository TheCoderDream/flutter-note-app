import 'package:flutter/material.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/providers/note-collection.dart';
import 'package:note_app/screens/note-screen.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatelessWidget {
  var uuid = Uuid();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<NoteCollection>(
          builder: (context, notes, child) {
            late String text;

            if (notes.count == 1) {
              text = 'Note(${notes.count})';
            } else if (notes.count == 0) {
              text = 'Note';
            } else {
              text = 'Notes(${notes.count})';
            }

            return Text(text);
          },
        ),
      ),
      body: _buildNoteList(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Note newNote = Note(
            id: uuid.v4()
          );

          Provider.of<NoteCollection>(context, listen: false).addNote(newNote);
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => NoteScreen(note: newNote,)));
        },
      ),
    );
  }

  Widget _buildNoteList() {
    return Consumer<NoteCollection>(
        builder: (context, collection, child) {
          List<Note> allNotes = collection.allNotes;

          if (collection.count == 0) {
            return const Center(
              child: Text('No Notes'),
            );
          }

          return ListView.builder(
              itemCount: allNotes.length,
              itemBuilder: (BuildContext context, int index) {
                var note = allNotes[index];

                return Dismissible(
                    key: Key(note.id),
                    background: Container(
                      color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Icon(Icons.delete_forever, color: Colors.white, size: 25,),
                            Icon(Icons.delete_forever, color: Colors.white, size: 25,)
                          ],
                        ),
                      ),
                    ),
                    child: Card(
                      margin: EdgeInsets.all(0),
                      child: ListTile(
                        title: Text(note.title),
                        subtitle: Text(note.noteBody),
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => NoteScreen(note: note))
                          );
                        },
                      ),
                    ),
                    onDismissed: (DismissDirection direction) {
                      Provider.of<NoteCollection>(context, listen: false).removeNote(note);
                    },
                );
              }
          );
        }
    );
  }
}