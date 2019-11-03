import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lbp/data/strings/Strings.dart';

class NoteDialog extends StatefulWidget {
  final String note;

  NoteDialog(this.note);

  @override
  _NoteDialogState createState() => _NoteDialogState(note: note);
}

class _NoteDialogState extends State<NoteDialog> {
  final TextEditingController _noteController;

  _NoteDialogState({String note})
      : _noteController = TextEditingController(text: note);

  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(Strings.getCapitalize("note")),
      contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 8.0),
      content: TextField(
        controller: _noteController,
        minLines: 2,
        maxLines: null,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
        FlatButton(
          onPressed: () => Navigator.pop(context, _noteController.value.text),
          child: Text("Save"),
        ),
      ],
    );
  }
}
