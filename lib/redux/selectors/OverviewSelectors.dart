import 'package:lbp/redux/AppState.dart';

final overviewLoadingSelector = (AppState state) => daysLoadingSelector(state);

final daysLoadingSelector = (AppState state) => state.days.loading;

final setNoteLoadingSelector = (AppState state) => state.setNote.loading;

final setNoteDataSelector = (AppState state) => state.setNote.data?.result;