import 'package:lbp/data/lessons/Days.dart';
import 'package:lbp/data/login/LoginData.dart';
import 'package:lbp/data/note/SetNoteResponse.dart';
import 'package:lbp/data/setData/SetDataResponse.dart';
import 'package:lbp/redux/AppState.dart';
import 'package:lbp/redux/actions/ForceReloadAction.dart';
import 'package:lbp/redux/actions/InitAction.dart';
import 'package:lbp/redux/reducers/DaysReducer.dart';
import 'package:lbp/redux/reducers/NotifyReducers.dart';
import 'package:lbp/redux/reducers/FetchReducer.dart';
import 'package:lbp/redux/reducers/GeneralReducer.dart';
import 'package:lbp/redux/reducers/ResetFeedbackReducer.dart';

AppState rootReducer(AppState state, action) {
  if (action is InitAction) {
    return AppState.initial();
  } else {
    return AppState(
      login: fetchReducer<LoginData>(state.login, action),
      days: fetchReducer<Days>(state.days, action, daysReducer),
      setData: fetchReducer<SetDataResponse>(state.setData, action),
      setNote: fetchReducer<SetNoteResponse>(state.setNote, action),
      general: generalReducer(state.general, action),
      notify: notifyReducer(state.notify, action),
      config: state.config,
      forceReloadCounter:
          state.forceReloadCounter + (action is ForceReloadAction ? 1 : 0),
      feedback: fetchReducer(state.feedback, action),
      resetFeedback: resetFeedbackReducer(state.resetFeedback, action),
    );
  }
}
