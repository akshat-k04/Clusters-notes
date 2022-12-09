import 'package:flutter/material.dart';

import '../models/notemodel.dart';

class NotesProvider with ChangeNotifier{
  List<Notemodel> notes=[];

  void addNote(Notemodel note){
    notes.add(note);
    notifyListeners();
  }

  void updateNote(Notemodel note){
    int indexOfNote = notes.indexOf(notes.firstWhere((element) => element.idf== note.idf));
    notes[indexOfNote]= note ;
    notifyListeners();
  }

  void deleteNote(Notemodel note){
    int indexOfNote = notes.indexOf(notes.firstWhere((element) => element.idf== note.idf));
    notes.removeAt(indexOfNote);
    notifyListeners();
  }

}