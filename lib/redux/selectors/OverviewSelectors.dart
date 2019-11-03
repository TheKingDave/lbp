import 'package:lbp/redux/AppState.dart';

final overviewLoadingSelector = (AppState state) => state.days.loading || state.setNote.loading;