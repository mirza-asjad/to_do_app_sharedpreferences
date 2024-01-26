// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app_sharedpreferences/models/note_model.dart';

class UserPreferences {

  

  

   Future<int> getNotesLength() async {
    List<NoteModel> notes = await getNotes();
    return notes.length;
  }


  Future<List<NoteModel>> getNotes() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? notesJson = sharedPreferences.getString('notes');
    if (notesJson != null) {
      List<dynamic> notesList = jsonDecode(notesJson);
      List<NoteModel> notes =
          notesList.map((json) => NoteModel.fromJson(json)).toList();
      return notes;
    } else {
      return [];
    }
  }

  void removeNote(String noteKey) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<NoteModel> notes = await getNotes();
    notes.removeWhere((note) => note.noteid == noteKey);
    sharedPreferences.setString('notes', jsonEncode(notes));
  }

  void addNote(NoteModel noteModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<NoteModel> notes = await getNotes();
    notes.add(noteModel);
    sharedPreferences.setString('notes', jsonEncode(notes));
  }
}
