import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app_sharedpreferences/controller/note_controller.dart';
import 'package:to_do_app_sharedpreferences/models/note_model.dart';
import 'package:to_do_app_sharedpreferences/util/colors/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app_sharedpreferences/util/routes/app_routes.dart';
import 'package:uuid/uuid.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({Key? key}) : super(key: key);

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  TextEditingController noteController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  //current date

  //current date
  late DateTime dateTime;
  late String formattedDate;
  late String noteId;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        dateController.text = picked.toLocal().toString().split(' ')[0];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    dateTime = DateTime.now();
    formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    noteId = const Uuid().v4();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primarybackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryappbarColor,
        title: const Text('Add Note'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.snackbar(
                colorText: Colors.white,
                'Note',
                'Note is Reset',
                backgroundColor: AppColors.primaryaddNoteColor,
                snackPosition: SnackPosition.BOTTOM,
              );
              setState(() {
                noteController.clear();
                dateController.clear();
              });
            },
            icon: const Icon(EneftyIcons.refresh_outline),
          ),
          IconButton(
            onPressed: () {
              // Get the note text from the noteController
              String noteText = noteController.text;

              // Get the due date from the dateController
              String dueDateText = dateController.text;
              try {
                if (noteText.isEmpty || dueDateText.isEmpty) {
                  throw Exception(
                      'Please fill in all fields'); // Custom exception for missing fields
                }
                NoteModel noteModel = NoteModel(
                    noteid: noteId,
                    note: noteText,
                    dueDate: dueDateText,
                    currentDate: formattedDate,
                    completed: false);
                UserPreferences().addNote(noteModel);
                Get.snackbar(
                  'Note Added',
                  'Kindly Fill all Fields',
                  backgroundColor: Colors.green,
                  snackPosition: SnackPosition.BOTTOM,
                  colorText: Colors.white,
                );
                Get.toNamed(RouteName.homePage);
              } catch (e) {
                Get.snackbar(
                  'Error',
                  'Kindly Fill all Fields',
                  backgroundColor: Colors.red,
                  snackPosition: SnackPosition.BOTTOM,
                  colorText: Colors.white,
                );
              }
            },
            icon: const Icon(EneftyIcons.tick_circle_outline),
          ),
        ],
      ),
      body: Hero(
        tag: 'noteTag',
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  maxLines: 5,
                  controller: noteController,
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Enter your note....',
                    hintText: 'Type something here...',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  readOnly: true,
                  controller: dateController,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: const Icon(EneftyIcons.calendar_2_bold),
                      onPressed: () => selectDate(context),
                    ),
                    labelText: 'Enter Due Date',
                    hintText: 'Select Due Date',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
