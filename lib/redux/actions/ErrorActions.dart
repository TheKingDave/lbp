class ErrorOccurredAction {
  ErrorOccurredAction(this.exception);

  final Exception exception;

  @override
  String toString() {
    return 'ErrorOccurredAction{exception: $exception}';
  }
}

class ErrorHandledAction {}