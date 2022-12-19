import 'dart:convert';
import 'dart:developer';

import 'package:clusters/models/notemodel.dart';
import 'package:http/http.dart' as http;
class ApiServices {
  static String _baseUrl = "https://cluster-notes.onrender.com/notes" ;


    static Future<void> addNote(Notemodel note)  async {
    Uri requestUri = Uri.parse(_baseUrl + "/add") ;
    var response = await http.post(requestUri,body: note.toMap());
    var decoded = jsonDecode(response.body);
    log(decoded.toString()) ;
  }

  static Future<void> updateNote(Notemodel note)  async {
    Uri requestUri = Uri.parse(_baseUrl + "/update") ;
    var response = await http.post(requestUri,body: note.toMap());
    var decoded = jsonDecode(response.body);
    log(decoded.toString()) ;
  }

  static Future<void> deleteNote(Notemodel note)  async {
    Uri requestUri = Uri.parse(_baseUrl + "/delete") ;
    var response = await http.post(requestUri,body: note.toMap());
    var decoded = jsonDecode(response.body);
    log(decoded.toString()) ;
  }

  static Future<List<Notemodel>> fetchnotes(String userid) async{
    Uri requestUri = Uri.parse("$_baseUrl/get") ;
    var response = await http.post(requestUri,body: {"email":userid});
    var decoded = jsonDecode(response.body);
    log(decoded.toString()) ;
    List<Notemodel> notes = [] ;
    for(var noteMap in decoded){
      Notemodel newnote = Notemodel.fromMap(noteMap);
      notes.add(newnote);
    }
    return notes ;
  }
}