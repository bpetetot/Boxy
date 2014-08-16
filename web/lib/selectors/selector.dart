part of boxy;

class Selector {

  final Widget selectedWidget;

  // Group
  final GElement _selectorGroup = new GElement();

  // Rubber
  final Rubber _rubber = new Rubber('rubber-selector');

  // Grips
  final GripResize _gripResize = new GripResize('resize-grip');
  final GripRotate _gripRotate = new GripRotate('rotate-grip');

  Selector(this.selectedWidget) {
    _selectorGroup.attributes['id'] = "selectors-1";
    _createRubber();
    _createGripResize();
    //_createGripRotate();
  }

  void attach(SvgElement selectorsView) {
    selectorsView.append(_selectorGroup);
    _rubber.attach(_selectorGroup);
    _gripResize.attach(_selectorGroup);
    //_gripRotate.attach(_selectorGroup);
  }

  void dettach() {
    _rubber.dettach();
    _gripResize.dettach();
    //_gripRotate.dettach();
    _selectorGroup.remove();
  }

  void updateSelectorsCoordinates() {
    // update selector items
    _rubber.updateCoordinates();
    _gripResize.updateCoordinates();
    //_gripRotate.updateCoordinates();
  }

  void _createRubber() {
    _rubber.selector = this;
    _rubber.x = selectedWidget.x - 2;
    _rubber.y = selectedWidget.y - 2;
    _rubber.width = selectedWidget.width + 4;
    _rubber.height = selectedWidget.height + 4;
  }

  void _createGripResize() {
    _gripResize.selector = this;
    _gripResize.x = selectedWidget.x + selectedWidget.width + 2;
    _gripResize.y = selectedWidget.y + selectedWidget.height + 2;
  }

  void _createGripRotate() {
    _gripRotate.selector = this;
    _gripRotate.x = selectedWidget.x + (selectedWidget.width / 2);
    _gripRotate.y = selectedWidget.y - 20;
  }

}

abstract class SelectorItem {

  String selectorName;

  static String currentSelector;

  SvgElement element;

  void onDrag(num dx, num dy);

  void onDragEnd(num dx, num dy);

  double get x;

  double get y;
  
  double get cx;

  double get cy;

  double get width;

  double get height;

  void set x(double x);

  void set y(double y);

  void set width(double width);

  void set height(double height);

  bool _dragged = false;

  GElement get selectorGroup => element.parent;

  SvgSvgElement get parentSvg => element.ownerSvgElement;

  SvgSvgElement get rootSvg => element.ownerSvgElement.ownerSvgElement;

  Point _lastMouse;
  Point _lastDelta;

  List listeners = [];

  void attach(SvgElement selectorsView) {
    selectorsView.append(element);

    listeners.add(element.onMouseDown.listen((event) => beginDrag(selectorName, event)));
    listeners.add(element.onMouseMove.listen((event) => drag(selectorName, event)));
    listeners.add(element.onMouseUp.listen((event) => endDrag(selectorName, event)));
    listeners.add(rootSvg.onMouseMove.listen((event) => drag(selectorName, event)));
    listeners.add(rootSvg.onMouseUp.listen((event) => endDrag(selectorName, event)));

    _lastMouse = parentSvg.createSvgPoint();
    _lastDelta = parentSvg.createSvgPoint();
  }

  void dettach() {
    // Remove listeners
    for (var listener in listeners) {
      listener.cancel();
    }
    // Remove element
    element.remove();
  }

  // ---- Draggable Methods
  void beginDrag(String selectorName, MouseEvent e) {
    currentSelector = selectorName;

    _dragged = true;
    _lastMouse.x = e.page.x;
    _lastMouse.y = e.page.y;
    _lastDelta.x = 0;
    _lastDelta.y = 0;

  }

  void drag(String selectorName, MouseEvent e) {

    if (selectorName == currentSelector && _dragged) {

      // Convert the global point into the space of the object you are dragging
      Point pt = parentSvg.createSvgPoint();
      pt.x = e.page.x - _lastMouse.x + _lastDelta.x;
      pt.y = e.page.y - _lastMouse.y + _lastDelta.y;

      pt = transformPointToElement(pt);

      onDrag(pt.x, pt.y);

      _lastDelta = pt;

      _lastMouse.x = e.page.x;
      _lastMouse.y = e.page.y;

    }
  }

  void endDrag(String selectorName, Event e) {
    if (selectorName == currentSelector) {
      _dragged = false;
      onDragEnd(_lastDelta.x, _lastDelta.y);
    }
  }

  Point transformPointToElement(Point point) {
    Matrix m = element.getTransformToElement(parentSvg).inverse();
    m.e = 0;
    m.f = 0;
    return point.matrixTransform(m);
  }

  void updateCoordinates() {
    var matrix = element.getCtm();
    var position = parentSvg.createSvgPoint();
    position.x = x;
    position.y = y;
    position = position.matrixTransform(matrix);

    var position2 = parentSvg.createSvgPoint();
    position2.x = x + width;
    position2.y = y + height;
    position2 = position2.matrixTransform(matrix);

    width = (position2.x - position.x).abs();
    height = (position2.y - position.y).abs();
    x = position.x;
    y = position.y;

    element.attributes["transform"] = "";

  }

}
