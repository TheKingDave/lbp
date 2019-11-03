import 'package:lbp/data/GeneralData.dart';
import 'package:lbp/data/lessons/Days.dart';
import 'package:lbp/data/login/LoginData.dart';
import 'package:lbp/data/note/SetNoteResponse.dart';
import 'package:lbp/data/setData/SetDataResponse.dart';
import 'package:lbp/redux/states/ConfigState.dart';
import 'package:lbp/redux/states/FetchState.dart';

class AppState {
  final FetchState<LoginData> login;
  final FetchState<Days> days;
  final FetchState<SetDataResponse> setData;
  final FetchState<SetNoteResponse> setNote;
  final GeneralData general;
  final Exception error;
  final ConfigState config;
  final int forceReloadCounter;

  AppState({
    this.login,
    this.days,
    this.setData,
    this.setNote,
    this.general,
    this.error,
    this.config,
    this.forceReloadCounter,
  });

  factory AppState.initial([GeneralData generalData]) {
    return AppState(
      login: FetchState<LoginData>.initial(),
      days: FetchState<Days>.initial(),
      setData: FetchState<SetDataResponse>.initial(),
      setNote: FetchState<SetNoteResponse>.initial(),
      general: generalData ?? GeneralData.initial(),
      error: null,
      config: ConfigState.initial(),
      forceReloadCounter: 0,
    );
  }
}
