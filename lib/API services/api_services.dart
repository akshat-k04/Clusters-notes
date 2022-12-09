import 'dart:convert';
import 'dart:developer';

import 'package:clusters/models/notemodel.dart';
import 'package:http/http.dart' as http;
class ApiServices {
  static String _baseUrl = "https://notes-ad661.web.app/notes" ;


    static Future<void> addNote(Notemodel note)  async {
    Uri requestUri = Uri.parse(_baseUrl + "/add") ;
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
}