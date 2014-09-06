part of boxy;

class Selector {

  final Widget selectedWidget;

  // Group
  final svg.GElement _selectorGroup = new svg.GElement();

  // Rubber
  Rubber _rubber;

  // Grips
  GripResize _gripResize;
  
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

  }

  void attach(svg.SvgElement selectorsView) {
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
    if (selectedWidget != null && !isVisible()) {
      _selectorGroup.attributes["display"] = "visible";
      selectedWidget.onSelect.add(new SelectWidgetEvent(selectedWidget));
    }
  }

  void hide() {
    if (selectedWidget != null && isVisible()) {
      _selectorGroup.attributes["display"] = "none";
      selectedWidget.onUnselect.add(new UnselectWidgetEvent(selectedWidget));
    }
  }
  
  bool isVisible() {
    return _selectorGroup.attributes["display"]  == "visible";
  }

}

abstract class SelectorItem extends Widget {

  String selectorName;

  Widget selectedWidget;

  static String currentSelector;

  bool _dragged = false;
  var _lastMouse;
  var _lastDelta;

  SelectorItem(this.selectedWidget);

  // ---- Override widget methods

  void attach(svg.SvgElement parent) {
    super.attach(parent);

    // Add listeners used to drag
    subscribedEvents.add(element.onMouseDown.listen((event) => beginDrag(selectorName, event)));
    subscribedEvents.add(rootSvg.onMouseMove.listen((event) => drag(selectorName, event)));
    subscribedEvents.add(rootSvg.onMouseUp.listen((event) => endDrag(selectorName, event)));

    _lastMouse = parentSvg.createSvgPoint();
    _lastDelta = parentSvg.createSvgPoint();
  }

  void dettach() {
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

  void onDrag(SelectorDragEvent e);

  void onDragEnd(SelectorDragEvent e);

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

      onDrag(new SelectorDragEvent(e, pt.x, pt.y));

      _lastDelta = pt;

      _lastMouse.x = e.offset.x;
      _lastMouse.y = e.offset.y;

    }
  }

  void endDrag(String selectorName, Event e) {
    if (selectorName == currentSelector) {
      _dragged = false;
      onDragEnd(new SelectorDragEvent(e, _lastDelta.x, _lastDelta.y));
    }
  }

}

class SelectorDragEvent {

  MouseEvent mouse;
  num dx;
  num dy;

  SelectorDragEvent(this.mouse, this.dx, this.dy);

}
