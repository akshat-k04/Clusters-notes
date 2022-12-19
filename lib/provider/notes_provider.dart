import 'package:clusters/API%20services/api_services.dart';
import 'package:flutter/material.dart';

import '../models/notemodel.dart';

class NotesProvider with ChangeNotifier{
  List<Notemodel> notes=[];
  static bool isLoading = true ;

  void sortNotes(){
    notes.sort((a,b)=> b.dateAddedf!.compareTo((a.dateAddedf! )));
  }

  void addNote(Notemodel note){
    notes.add(note);
    sortNotes();
    notifyListeners();
    ApiServices.addNote(note);
  }

  void updateNote(Notemodel note){
    int indexOfNote = notes.indexOf(notes.firstWhere((element) => element.idf== note.idf));
    notes[indexOfNote]= note ;
    sortNotes();
    notifyListeners();
    ApiServices.updateNote(note);
  }

  void deleteNote(Notemodel note){
    int indexOfNote = notes.indexOf(notes.firstWhere((element) => element.idf== note.idf));
    notes.removeAt(indexOfNote);
    sortNotes();
    notifyListeners();
    ApiServices.deleteNote(note);

  }

  void fetchnotes(String userid) async {
    notes= await ApiServices.fetchnotes(userid);
    sortNotes();
    isLoading = false ;
    notifyListeners();
  }


  List<Notemodel> filteredNotes(String query){
    return notes.where((element) => element.titlef!.toLowerCase().contains(query.toLowerCase())).toList();
  }

}