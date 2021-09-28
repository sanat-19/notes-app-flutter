import 'package:flutter/material.dart';

class NotesDetail extends StatefulWidget {
  String title;
  String desc;
  String addedOn;
  NotesDetail(this.title, this.desc, this.addedOn);
  @override
  _NotesDetailState createState() => _NotesDetailState();
}

class _NotesDetailState extends State<NotesDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.amber),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        elevation: 10,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.amber),
        ),
      ),
      body: Container(
          margin: EdgeInsets.all(5),
          color: Colors.amber,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: notedetailUI()),
    );
  }

  Widget notedetailUI() {
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.topRight,
            margin: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Text(
              widget.addedOn,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              "Description:",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Text(
              widget.desc,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
