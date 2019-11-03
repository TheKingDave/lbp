import 'package:lbp/data/NotifyModel.dart';

class ErrorOccurredAction {
  final String message;

  ErrorOccurredAction(this.message);

  @override
  String toString() {
    return 'ErrorOccurredAction{message $message}';
  }
}

class NotificationHandledAction {}

class NotifyAction {
  final NotifyModel notify;

  NotifyAction(this.notify);

  @override
  String toString() {
    return 'NotifyAction{notify: $notify}';
  }
}