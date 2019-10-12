import 'package:lbp/api/ApiRequest.dart';
import 'package:lbp/api/ApiResponse.dart';

abstract class Request<T extends ApiResponses, S extends ApiRequest> {

  Future<ApiResponse<T>> send(S req) async {
    throw UnimplementedError();
  }
}
