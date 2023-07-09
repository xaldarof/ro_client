import 'dart:async';

class StreamSocket<T> {
  final _socketResponse = StreamController<T>();

  void add(T event) {
    _socketResponse.sink.add(event);
  }

  Stream<T> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}
