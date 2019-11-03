class FetchState<T> {
  final bool loading;
  final String error;
  final T data;

  FetchState(this.data, this.loading, this.error);

  @override
  String toString() {
    return "FetchState<$T> {loading: $loading, error: $error, data: $data}";
  }

  factory FetchState.initial() => FetchState<T>(null, false, null);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is FetchState &&
              runtimeType == other.runtimeType &&
              loading == other.loading &&
              error == other.error &&
              data == other.data;

  @override
  int get hashCode =>
      loading.hashCode ^
      error.hashCode ^
      data.hashCode;

}
