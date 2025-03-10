import 'package:get/get.dart';

class NoteController extends GetxController {
  var noteList = [].obs;

  void addNote(String newNote) {
    noteList.add(newNote);
  }

  void deleteNote(int index) {
    noteList.removeAt(index);
  }

  void updateNote(String newContent, int index) {
    noteList[index] = newContent;
  }
}
