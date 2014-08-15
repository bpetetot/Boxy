part of boxy;

class Selector {

  final Widget selectedWidget;

  // Group
  final GElement _selectorGroup = new GElement();

  // Rubber
  final Rubber _rubber = new Rubber();

  // Grips
  final GripResize _gripResize = new GripResize();
  final GripRotate _gripRotate = new GripRotate();

  Selector(this.selectedWidget) {
    _selectorGroup.attributes['id'] = "selectors-1";
    _createRubber();
    _createGripResize();
    _createGripRotate();
  }

  void attach(SvgElement selectorsView) {
    selectorsView.append(_selectorGroup);
    _rubber.attach(_selectorGroup);
    _gripResize.attach(_selectorGroup);
    _gripRotate.attach(_selectorGroup);
  }

  void dettach() {
    _selectorGroup.remove();
  }

  void updateSelectorsCoordinates() {
    // update selector items
    _rubber.updateCoordinates();
    _gripResize.updateCoordinates();
    _gripRotate.updateCoordinates();

    // Reset transformations
    _selectorGroup.attributes["transform"] = "";
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

  SvgElement element;

  void onDrag(num dx, num dy);

  void onDragEnd(num dx, num dy);

  double get x;

  double get y;

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

  void attach(SvgElement selectorsView) {
    selectorsView.append(element);

    element.onMouseDown.listen((event) => beginDrag(event));
    element.onMouseMove.listen((event) => drag(event));
    element.onMouseUp.listen((event) => endDrag(event));
    rootSvg.onMouseMove.listen((event) => drag(event));
    rootSvg.onMouseUp.listen((event) => endDrag(event));

    _lastMouse = parentSvg.createSvgPoint();
    _lastDelta = parentSvg.createSvgPoint();
  }

  // ---- Draggable Methods
  void beginDrag(MouseEvent e) {
    _dragged = true;
    _lastMouse.x = e.page.x;
    _lastMouse.y = e.page.y;
    _lastDelta.x = 0;
    _lastDelta.y = 0;
  }

  void drag(MouseEvent e) {

    if (_dragged) {

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

  void endDrag(Event e) {
    _dragged = false;
    onDragEnd(_lastDelta.x, _lastDelta.y);
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
