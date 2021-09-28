import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/bloc/create_note_bloc.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.amber),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_to_photos_rounded,
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
          create: (BuildContext context) => CreateNoteBloc(),
          child: Align(alignment: Alignment.center, child: addNoteUI())),
    );
  }
}

class addNoteUI extends StatelessWidget {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  CreateNoteBloc createNoteBloc;

  @override
  Widget build(BuildContext context) {
    createNoteBloc = BlocProvider.of<CreateNoteBloc>(context);
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.5,
      margin: EdgeInsets.all(5),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: TextFormField(
              controller: titleController,
              cursorHeight: 20,
              decoration: InputDecoration(
                hintText: "Type...",
                labelText: "Title",
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    borderSide: BorderSide(color: Colors.amber)),
              ),
            ),
          ),
          Container(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
                maxWidth: MediaQuery.of(context).size.width,
              ),
              child: TextFormField(
                controller: descController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 6,
                cursorHeight: 20,
                decoration: InputDecoration(
                  hintText: "Type...",
                  labelText: "Description",
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                      borderSide: BorderSide(color: Colors.amber)),
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: ElevatedButton.icon(
              label: Text(
                "Save",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              onPressed: () async {
                createNoteBloc.add(NoteCreatedEvent(
                    title: titleController.text, desc: descController.text));
                titleController.clear();
                descController.clear();
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.save_rounded),
              style: ElevatedButton.styleFrom(elevation: 0),
            ),
          ),
        ],
      ),
    );
  }
}


