part of boxy;

class Draggable {

  SvgSvgElement parent;
  SvgElement widget;

  Draggable(this.widget, this.parent, onDrag(double newX, double newY)) {
    // Set widget draggable
    widget.onMouseDown.listen((event) => beginDrag(event));
    widget.onMouseMove.listen((event) => drag(event, onDrag));
    widget.onMouseUp.listen((event) => endDrag(event));
    parent.onMouseMove.listen((event) => drag(event, onDrag));
    parent.onMouseUp.listen((event) => endDrag(event));
  }

  // ---- Draggable Methods
  bool dragged = false;
  double lastTop;
  double lastLeft;

  void beginDrag(MouseEvent e) {
    dragged = true;
    //lastLeft = e.page.x + 0.0;
    //lastTop = e.page.y + 0.0;
  }

  void drag(MouseEvent e, dynamic onDrag) {
    if (dragged) {
      //double curX = double.parse(widget.getAttribute("x"));
      //double curY = double.parse(widget.getAttribute("y"));
      
      //int newX = curX + e.page.x - lastLeft;
      //int newY = curY + e.page.y - lastTop;
      
      double newX = e.page.x + 0.0;
      double newY = e.page.y + 0.0;

      if (onDrag != null) {
        onDrag(newX, newY);
      }
      
      //widget.attributes["x"] = "$newX";
      //widget.attributes["y"] = "$newY";

      //lastLeft = e.page.x;
      //lastTop = e.page.y;
    }
  }
  
  void endDrag(Event e) {
    dragged = false;
  }

}
