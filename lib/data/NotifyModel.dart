class NotifyModel {
  static const type_error = "error";
  static const type_ok = "ok";

  final String type;
  final String message;

  NotifyModel(this.type, this.message);
}