import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/bloc/delete_note_bloc.dart';
import 'package:notes_app/screen/notes_detail.dart';
import 'package:notes_app/service/database.dart';

class NotesList extends StatefulWidget {
  @override
  _NotesListState createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.note_alt_sharp,
              color: Colors.amber,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Add New Note",
              style: TextStyle(color: Colors.amber),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 10,
      ),
      body: BlocProvider(
        create: (BuildContext context) => DeleteNoteBloc(),
        child: Container(
          margin: EdgeInsets.only(bottom: 50),
          child: listUI(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.amber,
          size: 35,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed('add-note');
        },
        backgroundColor: Colors.black,
        elevation: 10,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class listUI extends StatelessWidget {
  DeleteNoteBloc deleteNoteBloc;
  @override
  Widget build(BuildContext context) {
    deleteNoteBloc = BlocProvider.of<DeleteNoteBloc>(context);
    return StreamBuilder(
      stream: Database.instance.fetchNotes(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return snapshot.hasData
            ? Container(
                child: ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data.docs[index];
                      String addedOn = data['addedOn'];
                      String desc = data['desc'];
                      return Container(
                        color: Colors.amber,
                        padding: EdgeInsets.only(bottom: 8, top: 8),
                        margin: EdgeInsets.all(5),
                        child: ListTile(
                          title: Text(
                            data['title'],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w800),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 3),
                                child: Text(
                                  desc,
                                  maxLines: 1,
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Text(
                                addedOn,
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete_outline_sharp,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              deleteNoteBloc.add(DeleteNoteEvent(id: data.id));
                            },
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NotesDetail(
                                      data['title'],
                                      data['desc'],
                                      data['addedOn']),
                                ));
                          },
                        ),
                      );
                    }),
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
