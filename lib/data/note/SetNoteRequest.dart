import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:lbp/api/ApiRequestWithKey.dart';
import 'package:lbp/data/lessons/TimeFrame.dart';
import 'package:lbp/etc/Constants.dart';

class SetNoteRequest extends ApiRequestWithKey {
  final TimeFrame period;
  final String note;

  SetNoteRequest({@required this.period, this.note});

  Map<String, dynamic> toJson() {
    return {
      'begin': period.begin.toIso8601String(),
      'end': period.end.toIso8601String(),
      'note': note,
      'sess_key': this.sessKey,
    };
  }

  @override
  String getBody() {
    return jsonEncode(this.toJson());
  }

  @override
  String getEndpoint() {
    return Constants.api_path_set_note;
  }

}