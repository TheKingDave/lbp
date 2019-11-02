import 'package:lbp/api/ApiResponse.dart';

class ValidationResponse extends ApiResponses {
  bool result;

  ValidationResponse({
    this.result,
  });

  factory ValidationResponse.fromJson(Map<String, dynamic> json) =>
      ValidationResponse(
        result: json["result"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
      };
}
