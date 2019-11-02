import 'package:lbp/data/ValidationResponse.dart';

class SetDataResponse extends ValidationResponse {

  SetDataResponse({bool result}): super(result: result);

  factory SetDataResponse.fromJson(Map<String, dynamic> json) =>
      SetDataResponse(
        result: json["result"],
      );
}
