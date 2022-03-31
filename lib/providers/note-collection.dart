import 'package:flutter/material.dart';
import 'package:note_app/models/note.dart';

class NoteCollection extends ChangeNotifier {
  final List<Note> _notes = [];

  int get count => _notes.length;

  List<Note> get allNotes => _notes;

  Note getById(String id) {
    return _notes.where((element) => element.id == id).first;
  }

  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void updateNote(String id, String body) {
    Note note = getById(id);
    note.body = body;
    notifyListeners();
  }

  void removeIfEmpty(Note note) {
    if (note.body == null || note.title.trim().isEmpty || (note.body != null && note.body!.isEmpty ) ) {
      removeNote(note);
    }
  }

  void removeNote(Note note) {
    _notes.remove(note);
    notifyListeners();
  }

  void updateTitle(String id, String title) {
    Note note = getById(id);
    note.title = title;
    notifyListeners();
  }
}