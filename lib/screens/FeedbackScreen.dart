import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lbp/data/strings/Strings.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/redux/actions/ApiActions.dart';
import 'package:lbp/ui/LoadingButton.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _feedbackController;

  _FeedbackScreenState() : _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _FeedbackScreenModel>(
        converter: (store) => _FeedbackScreenModel(
              sendFeedback: (fb) => store.dispatch(ApiSendFeedbackAction(fb)),
              loading: store.state.feedback.loading,
            ),
        builder: (_, model) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextField(
                    controller: _feedbackController,
                    autofocus: true,
                    minLines: 3,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: Strings.getCapitalize("your_feedback"),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 16)),
                  LoadingButton(
                    loading: model.loading,
                    onPressed: () =>
                        model.sendFeedback(_feedbackController.value.text),
                    child: Text(Strings.getCapitalize("submit")),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class _FeedbackScreenModel {
  final void Function(String feedback) sendFeedback;
  bool loading;

  _FeedbackScreenModel({this.sendFeedback, this.loading});
}
