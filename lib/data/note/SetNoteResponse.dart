import 'package:lbp/api/ApiResponse.dart';

class SetNoteResponse extends ApiResponses {
  bool result;

  SetNoteResponse({
    this.result,
  });

  factory SetNoteResponse.fromJson(Map<String, dynamic> json) =>
      SetNoteResponse(
        result: json["result"],
      );

  Map<String, dynamic> toJson() => {
    "result": result,
  };
}
