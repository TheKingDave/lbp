import 'dart:convert';

import 'package:lbp/etc/Constants.dart';
import 'package:meta/meta.dart';
import 'package:lbp/api/ApiRequest.dart';

class FeedbackRequest extends ApiRequest {
  String application;
  String subject;
  String user;
  String body;

  FeedbackRequest({
    this.application = Constants.feedback_application,
    this.subject = Constants.feedback_subject,
    @required this.user,
    @required this.body,
  });

  Map<String, dynamic> toJson() => {
        "application": application,
        "subject": subject + user,
        "body": body,
      };

  @override
  String getUrl() {
    return Constants.feedback_url;
  }

  @override
  String getBody() {
    return jsonEncode(toJson());
  }

  @override
  String getEndpoint() {
    return null;
  }
}
