part of boxy;

class Resizable {

  Widget _widget;
  SvgElement _group;
  SvgElement _anchor;

  static final double _SIZE = 10.0;

  Resizable(this._widget, this._group) {
    // Set element resizable
    _widget.element.onMouseDown.listen((event) => addAnchor(event));
  }

  void addAnchor(MouseEvent e) {
    if (_anchor == null) {
      _anchor = new SvgElement.tag("rect");
      _anchor.attributes = {
        "width": "$_SIZE",
        "height": "$_SIZE",
        "stroke": "red",
        "fill": "red",
        "stroke-width": "0.5"
      };
      _group.append(_anchor);
      
      updateAnchorPosition();
      
      Draggable draggable = new Draggable(_anchor, (curMouse, lastMouse) => onDrag(curMouse, lastMouse));
      draggable.dragCursor = "nwse-resize";
    }
  }

  void removeAnchor(MouseEvent e) {
    // TODO
  }

  void onDrag(Point curMouse, Point lastMouse) {

      SvgSvgElement svg = _anchor.ownerSvgElement;

      // Drag the anchor
      Point ptAnchor = svg.createSvgPoint();
      ptAnchor.x = curMouse.x - lastMouse.x;
      ptAnchor.y = curMouse.y - lastMouse.y;

      Matrix m = _anchor.getTransformToElement(svg).inverse();
      m.e = 0;
      m.f = 0;

      ptAnchor = ptAnchor.matrixTransform(m);

      double newX = double.parse(_anchor.attributes["x"]) + ptAnchor.x;
      double newY = double.parse(_anchor.attributes["y"]) + ptAnchor.y;

      newX = max(newX, _widget.x);
      newY = max(newY, _widget.y);

      _anchor.attributes["x"] = "${newX}";
      _anchor.attributes["y"] = "${newY}";

      // Resize the element
      Point ptElement = svg.createSvgPoint();
      ptElement.x = newX;
      ptElement.y = newY;

      ptElement = _widget.transformPointToElement(ptElement);

      _widget.width = max(ptElement.x - _widget.x, 1.0);
      _widget.height = max(ptElement.y - _widget.y, 1.0);

    }

    void updateAnchorPosition() {
      
      if (_anchor != null) {
        _anchor.attributes["x"] = "${_widget.x + _widget.width}";
        _anchor.attributes["y"] = "${_widget.y + _widget.height}";
      }

    }

}
