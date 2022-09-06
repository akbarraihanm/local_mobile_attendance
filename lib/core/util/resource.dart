class Resource<T> {
  T? data;
  String? message;

  Resource([this.data, this.message]);

  factory Resource.success([T? data]) => Resource(data);
  factory Resource.error([String? message, T? data]) => Resource(data, message);
}