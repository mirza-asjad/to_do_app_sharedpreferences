class NoteModel {
  String noteid;
  String note;
  String dueDate;
  String currentDate;
  bool completed;

  NoteModel({
    required this.noteid,
    required this.note,
    required this.dueDate,
    required this.currentDate,
    required this.completed,
  });

  // Convert NoteModel to a Map
  Map<String, dynamic> toJson() {
    return {
      'noteid': noteid,
      'note': note,
      'dueDate': dueDate,
      'currentDate': currentDate,
      'completed': completed,
    };
  }

  // Create a NoteModel instance from a Map
  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      noteid: json['noteid'],
      note: json['note'],
      dueDate: json['dueDate'],
      currentDate: json['currentDate'],
      completed: json['completed'],
    );
  }
}