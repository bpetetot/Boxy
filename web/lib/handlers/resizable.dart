part of boxy;

class Resizable {

  SvgSvgElement parent;
  SvgElement widgetGroup;
  SvgElement widget;

  ResizeBox box;

  Resizable(this.widget, this.parent, this.widgetGroup) {
    // Set widget draggable
    widgetGroup.onMouseDown.listen((event) => addResizeBox(event));
  }

  // ---- Resizable Methods

  void addResizeBox(MouseEvent e) {
    if (box == null) {
      box = new ResizeBox(widget, parent, widgetGroup);
    }
  }

  void removeResizeBox(MouseEvent e) {
    // add box
  }

  void moveBoxToParent() {
    if (box != null) {
      box.updateAnchorPosition();
    }
  }

}

class ResizeBox {

  SvgSvgElement parent;
  SvgElement resizedWidget;
  SvgElement widgetGroup;

  SvgElement anchor;

  final double SIZE = 10.0;

  var anchors = {};

  ResizeBox(this.resizedWidget, this.parent, this.widgetGroup) {
    createAnchor();
  }

  createAnchor() {
    anchor = new SvgElement.tag("rect");
    anchor.attributes = {
      "width": "$SIZE",
      "height": "$SIZE",
      "stroke": "red",
      "fill": "red",
      "stroke-width": "0.5"
    };

    updateAnchorPosition();

    Draggable draggable = new Draggable(anchor, parent, (curMouse, lastMouse) => onDrag(curMouse, lastMouse));
    draggable.dragCursor = "nwse-resize";

    widgetGroup.append(anchor);

  }

  void onDrag(Point curMouse, Point lastMouse) {

    double widgetX = double.parse(resizedWidget.attributes["x"]);
    double widgetY = double.parse(resizedWidget.attributes["y"]);
    double widgetW = double.parse(resizedWidget.attributes["width"]);
    double widgetH = double.parse(resizedWidget.attributes["height"]);

    // Drag the anchor
    Point ptAnchor = parent.createSvgPoint();
    ptAnchor.x = curMouse.x - lastMouse.x;
    ptAnchor.y = curMouse.y - lastMouse.y;

    Matrix m = anchor.getTransformToElement(parent).inverse();
    m.e = 0;
    m.f = 0;

    ptAnchor = ptAnchor.matrixTransform(m);

    double newX = double.parse(anchor.attributes["x"]) + ptAnchor.x;
    double newY = double.parse(anchor.attributes["y"]) + ptAnchor.y;

    newX = max(newX, widgetX);
    newY = max(newY, widgetY);

    anchor.attributes["x"] = "${newX}";
    anchor.attributes["y"] = "${newY}";

    // Resize the widget
    Point ptWidget = parent.createSvgPoint();
    ptWidget.x = newX;
    ptWidget.y = newY;

    Matrix mWidget = resizedWidget.getTransformToElement(parent).inverse();
    ptWidget = ptWidget.matrixTransform(mWidget);

    double w = max(ptWidget.x - widgetX, 1.0);
    double h = max(ptWidget.y - widgetY, 1.0);

    resizedWidget.attributes["width"] = "$w";
    resizedWidget.attributes["height"] = "$h";

    // updateAnchorPosition();

  }

  void updateAnchorPosition() {

    double widgetX = double.parse(resizedWidget.attributes["x"]);
    double widgetY = double.parse(resizedWidget.attributes["y"]);
    double widgetW = double.parse(resizedWidget.attributes["width"]);
    double widgetH = double.parse(resizedWidget.attributes["height"]);

    anchor.attributes["x"] = "${widgetX + widgetW}";
    anchor.attributes["y"] = "${widgetY + widgetH}";

  }

}
