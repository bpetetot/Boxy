part of boxy;

class WidgetHandlers {

  // Group
  final svg.GElement _handlerGroup = new svg.GElement();

  // Handlers
  final List<WidgetHandler> _handlers = [];

  bool attached = false;

  WidgetHandlers() {
    _handlerGroup.attributes['id'] = "handler-1";
    _handlerGroup.attributes["display"] = "none";
  }

  void addHandler(WidgetHandler handler) => _handlers.add(handler);

  void attach(svg.SvgElement handlersView) {
    if (!attached) {
      handlersView.append(_handlerGroup);
      _handlers.forEach((h) => h.attach(_handlerGroup, 0));
      attached = true;
    }
  }

  void enable() {
    if (!isVisible()) {
      _handlerGroup.attributes["display"] = "visible";
    }
  }

  void disable() {
    if (isVisible()) {
      _handlerGroup.attributes["display"] = "none";
    }
  }

  void dettach() {
    if (attached) {
      _handlers.forEach((h) => h.dettach());
      _handlers.clear();
      _handlerGroup.remove();
    }
  }

  bool isVisible() {
    return _handlerGroup.attributes["display"] == "visible";
  }

}

abstract class WidgetHandler extends Widget {

  String handlerName;

  List<Widget> _widgets = [];

  static String currentSelector;

  bool _dragged = false;
  var _lastMouse;
  var _lastDelta;

  WidgetHandler.forWidgets(this._widgets);

  WidgetHandler.forWidget(Widget widget) {
    _widgets = [widget];
  }

  // ---- widget getter

  Widget get widget => _widgets.isNotEmpty ? _widgets.first : null;

  List<Widget> get widgets => _widgets;

  // ---- Override widget methods

  void attach(svg.SvgElement parent, int order) {
    super.attach(parent, 0);

    subscribedEvents.add(element.onMouseDown.listen((event) => beginDrag(handlerName, event)));
    subscribedEvents.add(rootSvg.onMouseMove.listen((event) => drag(handlerName, event)));
    subscribedEvents.add(rootSvg.onMouseUp.listen((event) => endDrag(handlerName, event)));

    _lastMouse = parentSvg.createSvgPoint();
    _lastDelta = parentSvg.createSvgPoint();
  }

  void dettach() {
    super.dettach();
  }

  // ---- Draggable Methods

  void onDrag(HandlerDragEvent e);

  void onDragEnd(HandlerDragEvent e);

  void beginDrag(String handlerName, MouseEvent e) {
    currentSelector = handlerName;

    _dragged = true;
    _lastMouse.x = e.offset.x;
    _lastMouse.y = e.offset.y;
    _lastDelta.x = 0;
    _lastDelta.y = 0;

  }

  void drag(String handlerName, MouseEvent e) {

    if (handlerName == currentSelector && _dragged) {

      // Compute the delta coordinate to apply from the original coordinate of the element
      var pt = parentSvg.createSvgPoint();
      pt.x = e.offset.x - _lastMouse.x + _lastDelta.x;
      pt.y = e.offset.y - _lastMouse.y + _lastDelta.y;

      onDrag(new HandlerDragEvent(e, pt.x, pt.y));

      _lastDelta = pt;

      _lastMouse.x = e.offset.x;
      _lastMouse.y = e.offset.y;

    }
  }

  void endDrag(String handlerName, Event e) {
    if (handlerName == currentSelector) {
      _dragged = false;
      onDragEnd(new HandlerDragEvent(e, _lastDelta.x, _lastDelta.y));
    }
  }

}

class HandlerDragEvent {

  MouseEvent mouse;
  num dx;
  num dy;

  HandlerDragEvent(this.mouse, this.dx, this.dy);

}
