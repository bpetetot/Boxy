part of boxy;

class AnchorBoxy extends RectangleBoxy {
  
  Widget _parent;
  
  AnchorBoxy(Widget parent, double size) : super(parent.x + parent.width, parent.y + parent.height, size, size)  {
    _parent = parent;
    dragHandler = new DragHandler();
    dragHandler.dragCursor = "nwse-resize";
    
  }
  
  void dragWidget(Point curMouse, Point lastMouse) {
    
    super.dragWidget(curMouse, lastMouse);
    
    // Resize the element
    Point ptElement = svg.createSvgPoint();
    ptElement.x = x;
    ptElement.y = y;

    ptElement = _parent.transformPointToElement(ptElement);

    _parent.width = max(ptElement.x - _parent.x, 1.0);
    _parent.height = max(ptElement.y - _parent.y, 1.0);

 }
  
  void updateAnchorPosition() {
      x = _parent.x + _parent.width;
      y = _parent.y + _parent.height;
  }
  
}