import 'package:lbp/data/feedback/FeedbackResponse.dart';
import 'package:lbp/redux/states/FetchState.dart';

class FeedbackState {
  final String feedback;
  final FetchState<FeedbackResponse> fetch;

  FeedbackState({this.feedback, this.fetch});

  factory FeedbackState.initial() => FeedbackState(
      feedback: "", fetch: FetchState<FeedbackResponse>.initial());

  FeedbackState copyWith({
    String feedback,
    FetchState<FeedbackResponse> fetch,
  }) {
    return FeedbackState(
      feedback: feedback ?? this.feedback,
      fetch: fetch ?? this.fetch,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeedbackState &&
          runtimeType == other.runtimeType &&
          feedback == other.feedback &&
          fetch == other.fetch;

  @override
  int get hashCode => feedback.hashCode ^ fetch.hashCode;
}
