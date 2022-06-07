import 'dart:async';

enum CounterAction { increment, decrement, reset }

class CounterBloc {
  late int _counter;
  final _stateStreamController = StreamController<int>();

  StreamSink<int> get _counterSink => _stateStreamController.sink;
  Stream<int> get counterStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<CounterAction>();

  StreamSink<CounterAction> get eventSink => _eventStreamController.sink;
  Stream<CounterAction> get _eventStream => _eventStreamController.stream;

  CounterBloc() {
    _counter = 0;
    _eventStream.listen((event) {
      if (event == CounterAction.increment) {
        _counter++;
      } else if (event == CounterAction.decrement) {
        _counter--;
      } else if (event == CounterAction.reset) {
        _counter = 0;
      }
      _counterSink.add(_counter);
    });
  }
}
