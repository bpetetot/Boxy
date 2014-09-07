part of boxy;


class EventBoxyStreamProvider<T extends BoxyEvent> {

  final String _eventType;

  final Map<Widget, EventBoxyStream> _widgetStreams = {};

  final Map<BoxyView, EventBoxyStream> _viewStreams = {};

  EventBoxyStreamProvider(this._eventType);

  EventBoxyStream<T> forWidget(Widget w) {
    return _widgetStreams.putIfAbsent(w, () => new EventBoxyStream(_eventType, onCancel: _onCancelWidgetStreams(w)));
  }

  EventBoxyStream<T> forView(BoxyView b) {
    return _viewStreams.putIfAbsent(b, () => new EventBoxyStream(_eventType, onCancel: _onCancelViewStreams(b)));
  }

  _onCancelWidgetStreams(Widget w) {
    if (_widgetStreams.containsKey(w)) {
      _widgetStreams.remove(w);
    }
  }

  _onCancelViewStreams(BoxyView b) {
    if (_viewStreams.containsKey(b)) {
      _viewStreams.remove(b);
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

  EventBoxyStream(this._type, {onCancel}) {
    _streamController = new StreamController.broadcast(onCancel: onCancel, sync: true);
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

  TranslateEvent(num dx, num dy) : super('translate') {
    this.dx = dx;
    this.dy = dy;
  }

}

class ResizeEvent extends BoxyEvent {

  num dx, dy;

  ResizeEvent(num dx, num dy) : super('resize') {
    this.dx = dx;
    this.dy = dy;
  }

}

class SelectWidgetEvent extends BoxyEvent {

  Widget w;

  SelectWidgetEvent(Widget w) : super('select') {
    this.w = w;
  }

}

class UnselectWidgetEvent extends BoxyEvent {

  Widget w;

  UnselectWidgetEvent(Widget w) : super('unselect') {
    this.w = w;
  }

}

class UpdateEvent extends BoxyEvent {

  UpdateEvent() : super('update') {
  }

}

class SelectBoxEvent extends BoxyEvent {

  List<Widget> selectedWidgets;

  SelectBoxEvent(this.selectedWidgets) : super('selectbox') {
  }

}

class ChangeUserModeEvent extends BoxyEvent {

  UserMode mode;

  ChangeUserModeEvent(this.mode) : super('usermode') {
  }

}

abstract class BoxyEvent {

  String type;

  BoxyEvent(this.type);

}
