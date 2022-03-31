import 'package:flutter/material.dart';

class Note {
  static const String defaultName = 'New Note';
  final String id;
  String? body;
  String? _title;

  Note({required this.id, this.body, title }): _title = title;

  String get noteBody => body ?? '';
  
  int get charCount => (body ?? '').length;
  
  int get wordCount {
    List<String> el = (body ?? '').trim().split(' ');
    el.removeWhere((str) => str == ' ' || str.isEmpty);
    return el.length;
  }

  String get title {
    if (_title != null) {
      return _title as String;
    } else {
      return '';
    }
  }

  set title(String val) {
    _title = val;
  }
}

