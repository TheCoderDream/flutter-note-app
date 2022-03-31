import 'package:flutter/material.dart';
import 'package:note_app/providers/note-collection.dart';
import 'package:note_app/screens/home-screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      child: MaterialApp(
        title: 'Note App',
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: HomeScreen(),
        ),
      ),
      create: (BuildContext context) => NoteCollection(),
    )
  );
}