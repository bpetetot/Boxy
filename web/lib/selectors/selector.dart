part of boxy;

class Selector {

  final Widget selectedWidget;

  // Group
  final GElement _selectorGroup = new GElement();

  // Rubber
  Rubber _rubber;

  // Grips
  GripResize _gripResize;
  GripRotate _gripRotate;

  Selector(this.selectedWidget) {
    _selectorGroup.attributes['id'] = "selectors-1";

    // Add rubber
    if (selectedWidget.dragable) {
      _rubber = new Rubber('rubber-selector', selectedWidget);
    }

    // Add resize grip
    if (selectedWidget.resizable) {
      _gripResize = new GripResize('resize-grip', selectedWidget);
    }
    //_gripRotate = new GripRotate('rotate-grip', selectedWidget);

  }

  void attach(SvgElement selectorsView) {
    selectorsView.append(_selectorGroup);

    if (selectedWidget.dragable) {
      _rubber.attach(_selectorGroup);
    }
    if (selectedWidget.resizable) {
      _gripResize.attach(_selectorGroup);
    }
  }

  void dettach() {
    if (selectedWidget.dragable) {
      _rubber.dettach();
    }
    if (selectedWidget.resizable) {
      _gripResize.dettach();
    }
    _selectorGroup.remove();
  }

  void show() {
    _selectorGroup.attributes["display"] = "visible";
  }

  void hide() {
    _selectorGroup.attributes["display"] = "none";
  }

}

abstract class SelectorItem extends Widget {

  String selectorName;

  Widget selectedWidget;

  static String currentSelector;

  bool _dragged = false;
  var _lastMouse;
  var _lastDelta;

  List listeners = [];

  SelectorItem(this.selectedWidget);

  // ---- Override widget methods

  void attach(SvgElement parent) {
    super.attach(parent);

    // Add listeners used to drag
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
    super.dettach();
  }

  // ---- Show / Hide
  void show() {
    element.attributes["display"] = "visible";
  }

  void hide() {
    element.attributes["display"] = "none";
  }

  // ---- Draggable Methods

  void onDrag(num dx, num dy);

  void onDragEnd(num dx, num dy);

  void beginDrag(String selectorName, MouseEvent e) {
    currentSelector = selectorName;

    _dragged = true;
    _lastMouse.x = e.offset.x;
    _lastMouse.y = e.offset.y;
    _lastDelta.x = 0;
    _lastDelta.y = 0;

  }

  void drag(String selectorName, MouseEvent e) {

    if (selectorName == currentSelector && _dragged) {

      // Compute the delta coordinate to apply from the original coordinate of the element
      var pt = parentSvg.createSvgPoint();
      pt.x = e.offset.x - _lastMouse.x + _lastDelta.x;
      pt.y = e.offset.y - _lastMouse.y + _lastDelta.y;

      onDrag(pt.x, pt.y);

      _lastDelta = pt;

      _lastMouse.x = e.offset.x;
      _lastMouse.y = e.offset.y;

    }
  }

  void endDrag(String selectorName, Event e) {
    if (selectorName == currentSelector) {
      _dragged = false;
      onDragEnd(_lastDelta.x, _lastDelta.y);
    }
  }



}
