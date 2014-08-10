part of boxy;

class Draggable {

  SvgElement _element;
  bool _dragged = false;
  Point _lastMouse;

  String dragCursor = "move";

  Draggable(this._element, onDrag(Point curMouse, Point lastMouse)) {
    // Set element draggable
    _element.onMouseDown.listen((event) => beginDrag(event));
    _element.onMouseMove.listen((event) => drag(event, onDrag));
    _element.onMouseUp.listen((event) => endDrag(event));
    _element.onMouseOver.listen((event) => showDragCursor());
    _element.onMouseOut.listen((event) => showDragCursor());

    SvgSvgElement svg = _element.ownerSvgElement;
    svg.onMouseMove.listen((event) => drag(event, onDrag));
    svg.onMouseUp.listen((event) => endDrag(event));

    _lastMouse = svg.createSvgPoint();
  }

  // ---- Draggable Methods
  void beginDrag(MouseEvent e) {
    _dragged = true;
    _lastMouse.x = e.page.x;
    _lastMouse.y = e.page.y;
  }

  void drag(MouseEvent e, dynamic onDrag) {
    if (_dragged) {

      Point curMouse = _element.ownerSvgElement.createSvgPoint();
      curMouse.x = e.page.x;
      curMouse.y = e.page.y;

      if (onDrag != null) {
        onDrag(curMouse, _lastMouse);
      }

      _lastMouse.x = e.page.x;
      _lastMouse.y = e.page.y;

    }
  }

  void endDrag(Event e) {
    _dragged = false;
  }
  
  void showDragCursor() {
    _element.setAttribute("cursor", dragCursor);
  }
  
  void hideDragCursor() {
    _element.setAttribute("cursor", "pointer");
  }

}
