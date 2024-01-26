import 'package:flutter/material.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:to_do_app_sharedpreferences/animations/fade_in.dart';
import 'package:to_do_app_sharedpreferences/controller/note_controller.dart';
import 'package:to_do_app_sharedpreferences/models/note_model.dart';
import 'package:to_do_app_sharedpreferences/util/colors/app_colors.dart';
import 'package:to_do_app_sharedpreferences/util/routes/app_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool onChange = false;
  bool onChangeBox = false;
  late int notesLength = 0;
  late List<NoteModel> notes = [];
  String? notekey;

  @override
  void initState() {
    super.initState();
    initializeNotes();
  }

  Future<void> initializeNotes() async {
    List<NoteModel> retrievedNotes = await UserPreferences().getNotes();
    setState(() {
      notes = retrievedNotes;
      notesLength = notes.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primarybackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Note App',
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors
            .primaryappbarColor, // Assuming you have an instance of AppColors
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       showMenu(
        //         color: AppColors.primaryappbarColor,
        //         context: context,
        //         position: const RelativeRect.fromLTRB(10, 80, 0, 0),
        //         items: [
        //           PopupMenuItem(
        //             child: StatefulBuilder(
        //               //another concept
        //               builder: (BuildContext context, StateSetter setState) {
        //                 return Row(
        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     const Text(
        //                       'Change Theme',
        //                       style: TextStyle(color: Colors.white),
        //                     ),
        //                     const SizedBox(width: 16),
        //                     Switch(
        //                       value: onChange,
        //                       onChanged: (value) {
        //                         setState(() {
        //                           onChange = value;
        //                         });
        //                       },
        //                     ),
        //                   ],
        //                 );
        //               },
        //             ),
        //           ),
        //         ],
        //       );
        //     },
        //     icon: const Icon(EneftyIcons.setting_2_outline, size: 28),
        //   ),
        // ],
      ),
      body: Center(
        child: ListView.builder(
            itemCount: notesLength,
            itemBuilder: (context, index) {
              if (index < 0 || index >= notes.length) {
                // Handle index out of bounds gracefully
                return const SizedBox.shrink();
              }
              NoteModel note = notes[index];
              notekey = note.noteid;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: note.completed
                      ? Colors.green
                      : AppColors.primarylistColor.withOpacity(0.8),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Slidable(
                      endActionPane:
                          ActionPane(motion: const StretchMotion(), children: [
                        SlidableAction(
                          onPressed: (context) {
                            print('Iam Working');
                            try {
                              if (notekey != null) {
                                setState(() async {
                                  UserPreferences().removeNote(notekey!);
                                  await initializeNotes();
                                  
                                });
                                Get.snackbar(
                                  colorText: Colors.white,
                                  'Delete',
                                  'Note is Deleted',
                                  backgroundColor: Colors.green,
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              }
                            } catch (e) {
                              Get.snackbar(
                                colorText: Colors.white,
                                'Delete',
                                'Note unable to Delete',
                                backgroundColor: Colors.red,
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            }
                          },
                          backgroundColor: Colors.red,
                          icon: Icons.delete,
                        ),
                      ]),
                      child: FadeInAnimation(
                        delay: const Duration(seconds: 1),
                        child: ListTile(
                          title: Text(note.note.toString()),
                          trailing: Transform.scale(
                            scale: 1.5,
                            child: Checkbox(
                                shape: const CircleBorder(),
                                activeColor: AppColors.primaryaddNoteColor,
                                value: note.completed,
                                onChanged: (bool? value) {
                                  setState(() {
                                    note.completed = value!;
                                  });
                                }),
                          ),
                          subtitle: Text(note.currentDate.toString()),
                          leading: Text(note.dueDate.toString()),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'noteTag',
        backgroundColor: AppColors.primaryfloatingButtonColor,
        onPressed: () {
          Get.toNamed(RouteName.notePage);
        },
        child: const Icon(
          EneftyIcons.pen_add_outline,
          size: 32,
        ),
      ),
    );
  }
}
