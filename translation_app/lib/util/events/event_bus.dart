import 'dart:async';

import 'event.dart';

class EventBus {
  static final StreamController _streamController =
      StreamController.broadcast();

  static Stream<T> on<T>() =>
      _streamController.stream.where((event) => event is T).cast<T>();

  static void addEvent(Event event) {
    _streamController.add(event);
  }

  static void dispose() {
    _streamController.close();
  }
}
