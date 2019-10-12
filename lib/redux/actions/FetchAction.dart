import 'package:lbp/api/ApiRequest.dart';
import 'package:lbp/api/ApiResponse.dart';
import 'package:lbp/api/requests/PostRequest.dart';

class FetchAction<T> {}

class FetchDataAction<T extends ApiResponses, REQ extends ApiRequest>
    implements FetchAction<T> {
  REQ request;

  FetchDataAction(this.request);

  FetchActionStart<T> getStartAction() {
    return FetchActionStart<T>();
  }

  Future<FetchAction<T>> fetchData() async {
    final res = await PostRequest<T, REQ>().send(request);
    if(res.hasError()) {
      return FetchActionFailure(Exception(res.error));
    }
    return FetchActionSuccess(res.resp);
  }
}

class FetchActionStart<T> implements FetchAction<T> {}

class FetchActionSuccess<T> implements FetchAction<T> {
  T data;

  FetchActionSuccess(this.data);
}

class FetchActionFailure<T> implements FetchAction<T> {
  Exception error;

  FetchActionFailure(this.error);
}
