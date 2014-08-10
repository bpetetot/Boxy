part of boxy;

class DragHandler extends WidgetHandler {

  Widget _widget;
  bool _dragged = false;
  Point _lastMouse;

  String dragCursor = "move";
  
  DragHandler() : super("drag") {}
  
  void register(Widget widget, [onDrag(Point curMouse, Point lastMouse)]) {
    _widget = widget;
    
    // Set element draggable
   _widget.element.onMouseDown.listen((event) => beginDrag(event));
   _widget.element.onMouseMove.listen((event) => drag(event, onDrag));
   _widget.element.onMouseUp.listen((event) => endDrag(event));
   _widget.element.onMouseOver.listen((event) => showDragCursor());
   _widget.element.onMouseOut.listen((event) => showDragCursor());
  
   _widget.svg.onMouseMove.listen((event) => drag(event, onDrag));
   _widget.svg.onMouseUp.listen((event) => endDrag(event));
  
   _lastMouse = _widget.svg.createSvgPoint();
  }

  // ---- Draggable Methods
  void beginDrag(MouseEvent e) {
    _dragged = true;
    _lastMouse.x = e.page.x;
    _lastMouse.y = e.page.y;
  }

  void drag(MouseEvent e, dynamic onDrag) {
    if (_dragged) {

      Point curMouse = _widget.svg.createSvgPoint();
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
    _widget.element.setAttribute("cursor", dragCursor);
  }
  
  void hideDragCursor() {
    _widget.element.setAttribute("cursor", "pointer");
  }

}
