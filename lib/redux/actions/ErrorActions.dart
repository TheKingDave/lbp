class ErrorOccurredAction {
  final String message;

  ErrorOccurredAction(this.message);

  @override
  String toString() {
    return 'ErrorOccurredAction{message $message}';
  }
}

class ErrorHandledAction {}