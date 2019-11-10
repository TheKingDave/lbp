import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lbp/data/strings/Strings.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/redux/actions/ApiActions.dart';
import 'package:lbp/redux/actions/ResetFeedbackActions.dart';
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
        distinct: true,
        converter: (store) => _FeedbackScreenModel(
              sendFeedback: (fb) => store.dispatch(ApiSendFeedbackAction(fb)),
              loading: store.state.feedback.loading,
              resetFeedback: store.state.resetFeedback,
              markAsReset: () => store.dispatch(ResetFeedbackHandledAction()),
            ),
        onWillChange: (model) {
          if (model.resetFeedback) {
            _feedbackController.value = TextEditingValue(text: "");
            model.markAsReset();
          }
        },
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
  final bool loading;
  final bool resetFeedback;
  final void Function() markAsReset;

  _FeedbackScreenModel(
      {this.sendFeedback, this.loading, this.resetFeedback, this.markAsReset});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _FeedbackScreenModel &&
          runtimeType == other.runtimeType &&
          sendFeedback == other.sendFeedback &&
          loading == other.loading &&
          resetFeedback == other.resetFeedback &&
          markAsReset == other.markAsReset;

  @override
  int get hashCode =>
      sendFeedback.hashCode ^
      loading.hashCode ^
      resetFeedback.hashCode ^
      markAsReset.hashCode;
}
