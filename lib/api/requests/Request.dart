import 'package:lbp/api/ApiRequest.dart';
import 'package:lbp/api/ApiResponse.dart';

abstract class Request<T extends ApiResponses> {

  Future<ApiResponse<T>> send(ApiRequest req, String sessKey) async {
    throw UnimplementedError();
  }
}
