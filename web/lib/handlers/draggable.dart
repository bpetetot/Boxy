part of boxy;

class Draggable {

  SvgSvgElement parent;
  SvgElement widget;
  
  String dragCursor = "move";

  Draggable(this.widget, this.parent, onDrag(Point curMouse, Point lastMouse)) {
    // Set widget draggable
    widget.onMouseDown.listen((event) => beginDrag(event));
    widget.onMouseMove.listen((event) => drag(event, onDrag));
    widget.onMouseUp.listen((event) => endDrag(event));
    parent.onMouseMove.listen((event) => drag(event, onDrag));
    parent.onMouseUp.listen((event) => endDrag(event));

    lastMouse = parent.createSvgPoint();
  }

  // ---- Draggable Methods
  bool dragged = false;
  Point lastMouse;

  void beginDrag(MouseEvent e) {
    dragged = true;
    lastMouse.x = e.page.x;
    lastMouse.y = e.page.y;
    
    widget.setAttribute("cursor", dragCursor);
  }

  void drag(MouseEvent e, dynamic onDrag) {
    if (dragged) {

      Point curMouse = parent.createSvgPoint();
      curMouse.x = e.page.x;
      curMouse.y = e.page.y;

      if (onDrag != null) {
        onDrag(curMouse, lastMouse);
      }

      lastMouse.x = e.page.x;
      lastMouse.y = e.page.y;
      
    }
  }

  void endDrag(Event e) {
    dragged = false;
  }

}
