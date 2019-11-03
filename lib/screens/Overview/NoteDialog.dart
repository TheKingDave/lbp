import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lbp/data/lessons/TimeFrame.dart';
import 'package:lbp/data/strings/Strings.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/redux/actions/ApiActions.dart';
import 'package:lbp/redux/actions/ErrorActions.dart';
import 'package:lbp/redux/selectors/OverviewSelectors.dart';

class NoteDialog extends StatefulWidget {
  final TimeFrame period;
  final String note;

  NoteDialog({this.note, this.period});

  @override
  _NoteDialogState createState() =>
      _NoteDialogState(note: note, period: period);
}

class _NoteDialogState extends State<NoteDialog> {
  final TimeFrame period;
  final String note;
  final TextEditingController _noteController;

  _NoteDialogState({this.note, this.period})
      : _noteController = TextEditingController(text: note);

  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _NoteDialogModel>(
        converter: (store) => _NoteDialogModel(
            loading: setNoteLoadingSelector(store.state),
            reqOk: setNoteDataSelector(store.state),
            setNote: (period, note) => store.dispatch(ApiSetNoteAction(
                  period: period,
                  note: note,
                )),
            showError: (ex) => store.dispatch(ErrorOccurredAction(ex))),
        builder: (_, model) {
          if(model.loading == false && model.reqOk == true) {
            Navigator.pop(context);
          }

          return AlertDialog(
            title: Text(
                "${Strings.getWeekdayString(period.getWeekDay())} ${period.toString()}"),
            contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 8.0),
            content: TextField(
              controller: _noteController,
              minLines: 2,
              maxLines: null,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: Strings.getCapitalize("note"),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel"),
              ),
              FlatButton(
                onPressed: model.loading
                    ? null
                    : () {
                        final newNote = _noteController.value.text;
                        if (note == newNote) {
                          Navigator.pop(context);
                        }
                        model.setNote(period, newNote);
                      },
                child:
                    model.loading ? CircularProgressIndicator() : Text("Save"),
              ),
            ],
          );
        });
  }
}

class _NoteDialogModel {
  final bool loading;
  final bool reqOk;
  final Function(TimeFrame period, String note) setNote;
  final Function(Exception err) showError;

  _NoteDialogModel({this.loading, this.reqOk, this.setNote, this.showError});
}
