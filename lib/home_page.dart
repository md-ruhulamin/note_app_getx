import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app_getx/note_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  TextEditingController newNoteController = TextEditingController();
  final NoteController controller = Get.put(NoteController());

  final TextEditingController updatedContentController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    print(Get.width);
    print(controller.noteList.length);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Notes",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: newNoteController,
            ),
            ElevatedButton(
                onPressed: () {
                  if (newNoteController.text.isNotEmpty) {
                    controller.addNote(newNoteController.text);
                    newNoteController.clear();
                  }
                },
                child: Text("Add Note")),
            Expanded(
              child: Obx(() => ListView.builder(
                  itemCount: controller.noteList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          onTap: () {
                            updatedContentController.text =
                                controller.noteList[index];
                            showDialog(
                                context: context,
                                builder: (contex) {
                                  return AlertDialog(
                                    title: Text("Note Update"),
                                    content: TextField(
                                      controller: updatedContentController,
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            if (updatedContentController
                                                .text.isNotEmpty) {
                                              controller.updateNote(
                                                  updatedContentController.text,
                                                  index);
                                              Get.back();
                                            }
                                          },
                                          child: Text("Update")),
                                      TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: Text("Cancel")),
                                    ],
                                  );
                                });
                          },
                          leading: CircleAvatar(
                            backgroundColor: Colors.deepPurple,
                            child: Text(
                              "${index+1}",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(
                            controller.noteList[index],
                            style: TextStyle(fontSize: 25),
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                controller.deleteNote(index);
                              },
                              icon: Icon(Icons.delete)),
                        ),
                      ),
                    );
                  })),
            ),
          ],
        ),
      ),
    );
  }
}
