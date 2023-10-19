import 'package:flutter/material.dart';
import 'package:sqlite_crud/JsonModels/note_model.dart';
import 'package:sqlite_crud/SQlite/sqlite.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({super.key});

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final title = TextEditingController();
  final content = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final db = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create note"),
        actions: [
          IconButton(
              onPressed: () {
                //add note button
                if (formKey.currentState!.validate()) {
                  db
                      .createNode(NoteModel(
                          noteTitle: title.text,
                          noteContent: content.text,
                          createdAt: DateTime.now().toIso8601String()))
                      .whenComplete(() => Navigator.of(context).pop(true));
                }
              },
              icon: const Icon(Icons.check))
        ],
      ),
      body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Title is required';
                    }
                    return null;
                  },
                  controller: title,
                  decoration: const InputDecoration(label: Text("Title")),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Content is required';
                    }
                    return null;
                  },
                  controller: content,
                  decoration: const InputDecoration(label: Text("Content")),
                )
              ],
            ),
          )),
    );
  }
}
