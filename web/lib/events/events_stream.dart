part of boxy;


class EventBoxyStreamProvider<T extends BoxyEvent> {

  final String _eventType;

  final Map<Widget, EventBoxyStream> _streams = {}; 
  
  const EventBoxyStreamProvider(this._eventType);

  EventBoxyStream<T> forWidget(Widget w) {
    return _streams.putIfAbsent(w, () => new EventBoxyStream(_eventType, w, onCancel : _onCancel(w)));     
  }
  
  _onCancel(Widget w) {
    if (_streams.containsKey(w)) {
      _streams.remove(w);
    }
  }
  
}

abstract class BoxyStream<T extends BoxyEvent> implements Stream<T> {
  /**
   * Add the following custom event to the stream for dispatching to interested
   * listeners.
   */
  void add(T event);
}

class EventBoxyStream<T extends BoxyEvent> extends Stream<T> implements BoxyStream<T> {

  StreamController<T> _streamController;

  String _type;
  
  Widget _widget;

  EventBoxyStream(this._type, this._widget, { onCancel}) {
    _streamController = new StreamController.broadcast(onCancel : onCancel, sync: true);
  }

  // Delegate all regular Stream behavior to our wrapped Stream.
  StreamSubscription<T> listen(void onData(T event), {Function onError, void onDone(), bool cancelOnError}) {
    return _streamController.stream.listen(onData, onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }

  Stream<T> asBroadcastStream({void onListen(StreamSubscription subscription), void onCancel(StreamSubscription subscription)}) => _streamController.stream;

  bool get isBroadcast => true;

  void add(T event) {
    if (event.type == _type) _streamController.add(event);
  }
}

class TranslateEvent extends BoxyEvent {

  num dx, dy;

  TranslateEvent (num dx, num dy) : super('translate') {
    this.dx = dx;
    this.dy = dy;
  }

}

class ResizeEvent extends BoxyEvent {

  num dx, dy;

  ResizeEvent (num dx, num dy) : super('resize') {
    this.dx = dx;
    this.dy = dy;
  }

}

class UpdateEvent extends BoxyEvent {

  UpdateEvent () : super('update') {
  }

}

abstract class BoxyEvent {
  
  String type;
  
  BoxyEvent(this.type);

}
