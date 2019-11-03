import 'package:lbp/api/ApiResponse.dart';

class FeedbackResponse extends ApiResponses {
  bool result;

  FeedbackResponse({
    this.result,
  });

  factory FeedbackResponse.fromJson(Map<String, dynamic> json) =>
      FeedbackResponse(
        result: json["result"],
      );

  Map<String, dynamic> toJson() => {
    "result": result,
  };
}
