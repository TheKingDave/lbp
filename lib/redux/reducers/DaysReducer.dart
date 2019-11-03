import 'package:lbp/data/lessons/Class.dart';
import 'package:lbp/data/lessons/Days.dart';
import 'package:lbp/etc/helpers.dart';
import 'package:lbp/redux/actions/UserActions.dart';
import 'package:redux/redux.dart';

final Reducer<Days> daysReducer = combineReducers<Days>([
  TypedReducer<Days, SetNoteAction>(_noteReducer),
]);

Days _noteReducer(Days state, SetNoteAction a) {
  for(Day d in state.days) {
    for(Class c in d.classes) {
      if(c.period == a.period) {
        c.note = a.note;
      }
    }
  }

  return state;
}