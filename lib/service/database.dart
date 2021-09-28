import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Database {
  FirebaseFirestore db;
  static Database instance = Database();
  Database() {
    db = FirebaseFirestore.instance;
  }

  addNote(String title, String desc) {
    DateTime mytime = DateTime.now();
    String time = DateFormat.yMMMd().add_jm().format(mytime).toString();
    return db.collection("Notes").add({
      "title": title,
      "desc": desc,
      "ts": Timestamp.now(),
      "addedOn": time,
    });
  }

  deleteNote(String noteID) {
    return db.collection("Notes").doc(noteID).delete();
  }

  fetchNotes() {
    return db.collection("Notes").orderBy('ts', descending: true).snapshots();
  }
}
