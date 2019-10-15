import 'package:lbp/api/ApiRequest.dart';
import 'package:lbp/api/ApiResponse.dart';
import 'package:lbp/api/requests/PostRequest.dart';
import 'package:redux/redux.dart';

import '../AppState.dart';

class FetchAction<T> {}

class FetchDataAction<T extends ApiResponses, REQ extends ApiRequest>
    implements FetchAction<T> {
  REQ request;

  FetchDataAction(this.request);

  FetchActionStart<T> getStartAction() {
    return FetchActionStart<T>();
  }

  fetchData(Store<AppState> store, NextDispatcher next) async {
    next(getStartAction());
    final res = await PostRequest<T, REQ>().send(request);
    if(res.hasError()) {
      next(FetchActionFailure<T>(Exception(res.error)));
      request.onFailure(store, next);
    } else {
      next(FetchActionSuccess<T>(res.resp));
      request.onSuccess(store, next);
    }
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
