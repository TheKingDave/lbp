import 'package:flutter/cupertino.dart';
import 'package:lbp/data/lessons/TimeFrame.dart';

class LogoutAction {}

class SetNoteAction {
  final TimeFrame period;
  final String note;

  SetNoteAction({@required this.period, this.note});
}