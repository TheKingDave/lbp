import 'package:lbp/api/ApiRequest.dart';
import 'package:lbp/api/ApiResponse.dart';
import 'package:lbp/api/requests/PostRequest.dart';
import 'package:lbp/redux/selectors/GeneralSelectors.dart';
import 'package:redux/redux.dart';

import '../AppState.dart';

class FetchAction<T> {}

class FetchDataAction<T extends ApiResponses>
    implements FetchAction<T> {
  ApiRequest request;

  FetchDataAction(this.request);

  FetchActionStart<T> getStartAction() {
    return FetchActionStart<T>();
  }

  fetchData(Store<AppState> store, NextDispatcher next) async {
    final sessKey =  sessKeySelector(store.state);

    next(getStartAction());
    final res = await PostRequest<T>().send(request, sessKey);
    if(res.hasError()) {
      next(FetchActionFailure<T>(res.error));
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
  String error;

  FetchActionFailure(this.error);
}
