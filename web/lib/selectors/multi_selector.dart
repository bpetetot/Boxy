part of boxy;

class MultiSelector extends Widget {

  static final double _LINE_WIDTH = 1.0;
  static final String _COLOR = "red";
  static final String _CURSOR = "move";

  static final EventBoxyStreamProvider<SelectBoxEvent> selectEvent = new EventBoxyStreamProvider<SelectBoxEvent>('selectbox');
  EventBoxyStream<SelectBoxEvent> get onSelectBox => selectEvent.forWidget(this);

  List<Widget> _watchedWidgets;

  bool _enabled = true;

  MultiSelector() {
    element = new svg.RectElement();
    element.attributes = {
      "x": "0",
      "y": "0",
      "width": "1",
      "height": "1",
      "cursor": _CURSOR,
      "stroke": _COLOR,
      "stroke-width": "${_LINE_WIDTH}",
      "fill": "transparent",
      "stroke-dasharray": "10 5",
      "vector-effect": "non-scaling-stroke",
      "display": "none"
    };
  }

  bool _dragged = false;
  var _lastMouse;
  var _lastDelta;

  // ---- Override widget methods

  void attachMultiselector(svg.SvgElement svgView, List<Widget> watchedWidgets) {
    super.attach(svgView);
    this._watchedWidgets = watchedWidgets;

    _lastMouse = element.ownerSvgElement.createSvgPoint();
    _lastDelta = element.ownerSvgElement.createSvgPoint();
    element.ownerSvgElement.ownerSvgElement.onMouseDown.listen((event) => beginDrag(event));
  }

  void enable() {
    _enabled = true;
  }

  void disabled() {
    hide();
    _enabled = false;
  }


  // ---- Show / Hide
  void show() {
    super.show();
    // Add listeners used to drag
    subscribedEvents.add(element.ownerSvgElement.ownerSvgElement.onMouseMove.listen((event) => drag(event)));
    subscribedEvents.add(element.ownerSvgElement.ownerSvgElement.onMouseUp.listen((event) => endDrag(event)));
  }

  void hide() {
    super.hide();
    subscribedEvents.forEach((e) => e.cancel());
  }

  // ---- Draggable Methods
  void beginDrag(MouseEvent e) {
    if (_enabled) {
      show();

      x = 0.0;
      y = 0.0;
      width = 1.0;
      height = 1.0;

      _dragged = true;
      _lastMouse.x = e.offset.x;
      _lastMouse.y = e.offset.y;
      _lastDelta.x = 0;
      _lastDelta.y = 0;

      var pt = element.ownerSvgElement.createSvgPoint();
      translate(e.offset.x, e.offset.y);
      updateCoordinates();
    }
  }

  void drag(MouseEvent e) {
    if (_dragged && _enabled) {
      // Compute the delta coordinate to apply from the original coordinate of the element
      var pt = element.ownerSvgElement.createSvgPoint();
      pt.x = e.offset.x - _lastMouse.x + _lastDelta.x;
      pt.y = e.offset.y - _lastMouse.y + _lastDelta.y;

      scale(pt.x, pt.y);

      _lastDelta = pt;
      _lastMouse.x = e.offset.x;
      _lastMouse.y = e.offset.y;
    }
  }

  void endDrag(MouseEvent e) {
    if (_enabled) {
      scale(_lastDelta.x, _lastDelta.y);
      updateCoordinates();
      onSelectBox.add(new SelectBoxEvent(intersectedWidgets()));
      hide();
      _dragged = false;
    }
  }

  double get x => double.parse(element.attributes["x"]);

  double get cx => x + (width / 2);

  double get y => double.parse(element.attributes["y"]);

  double get cy => y + (height / 2);

  double get width => double.parse(element.attributes["width"]);

  double get height => double.parse(element.attributes["height"]);

  set x(double x) => element.attributes["x"] = "$x";

  set y(double y) => element.attributes["y"] = "$y";

  set width(double width) => element.attributes["width"] = "$width";

  set height(double height) => element.attributes["height"] = "$height";

  List<Widget> intersectedWidgets() {
    return _watchedWidgets.where((w) => SvgUtils.intersectElements(w.element, element)).toList();
  }

}

class SelectBoxEvent extends BoxyEvent {

  List<Widget> selectedWidgets;

  SelectBoxEvent(this.selectedWidgets) : super('selectbox') {
  }

}
