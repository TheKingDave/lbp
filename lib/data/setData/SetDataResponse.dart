import 'package:lbp/api/ApiResponse.dart';

class SetDataResponse extends ApiResponses{
  bool result;

  SetDataResponse({
    this.result,
  });

  factory SetDataResponse.fromJson(Map<String, dynamic> json) => SetDataResponse(
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
  };
}