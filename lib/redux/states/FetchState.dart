class FetchState<T> {
  final bool loading;
  final Exception error;
  final T data;

  FetchState(this.data, this.loading, this.error);

  @override
  String toString() {
    return "FetchState<$T> {loading: $loading, error: $error, data: $data}";
  }

  static FetchState<T> initial<T>() {
    return FetchState<T>(null, false, null);
  }
}
