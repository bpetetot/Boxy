part of boxy;

class Resizable {
  
  SvgSvgElement parent;
  SvgElement widgetGroup;
  SvgElement widget;

  Resizable(this.widget, this.parent, this.widgetGroup) {
    // Set widget draggable
    widgetGroup.onMouseDown.listen((event) => addResizeBox(event));
  }

  // ---- Resizable Methods

  void addResizeBox(MouseEvent e) {
    // add box
    ResizeBox box = new ResizeBox(widget, parent, widgetGroup);
  }

  void removeResizeBox(MouseEvent e) {
    // add box
  }

}

class ResizeBox {

  SvgSvgElement parent;
  SvgElement resizedWidget;
  SvgElement widgetGroup;

  SvgElement anchorsGroup;

  final double SIZE = 5.0;

  var anchors = {};

  ResizeBox(this.resizedWidget, this.parent, this.widgetGroup) {
    
    //http://stackoverflow.com/questions/4850821/svg-coordinates-with-transform-matrix
    
    createAnchor(AnchorPosition.TOP);
    createAnchor(AnchorPosition.BOTTOM);
    createAnchor(AnchorPosition.LEFT);
    createAnchor(AnchorPosition.RIGHT);
    createAnchor(AnchorPosition.TOP_LEFT);
    createAnchor(AnchorPosition.TOP_RIGHT);
    createAnchor(AnchorPosition.BOTTOM_LEFT);
    createAnchor(AnchorPosition.BOTTOM_RIGHT);
  }

  createAnchor(AnchorPosition position) {

    SvgElement anchorsGroup = new SvgElement.tag("g");

    SvgElement anchor = new SvgElement.tag("rect");
    anchor.attributes = {
      "width": "$SIZE",
      "height": "$SIZE",
      "stroke": "red",
      "fill": "transparent",
      "stroke-width": "0.3"
    };

    anchors[position] = anchor;

    double widgetX = double.parse(resizedWidget.attributes["x"]);
    double widgetY = double.parse(resizedWidget.attributes["y"]);
    setAnchorPosition(position, widgetX, widgetY);
    
    Draggable draggable = new Draggable(anchor, parent, (newX, newY) => onDrag(newX, newY, anchor, position));
    
    anchorsGroup.append(anchor);
    widgetGroup.append(anchor);

  }

  void onDrag(double x, double y, SvgElement anchor, AnchorPosition position) {
    SvgElement anchor = anchors[position];
    
    double widgetX = double.parse(resizedWidget.attributes["x"]);
    double widgetY = double.parse(resizedWidget.attributes["y"]);
    double widgetW = double.parse(resizedWidget.attributes["width"]);
    double widgetH = double.parse(resizedWidget.attributes["height"]);

    switch (position) {

      case AnchorPosition.TOP:
        anchor.attributes["x"] = "${widgetX + (widgetW / 2) - (SIZE/2)}";
        anchor.attributes["y"] = "${y - (SIZE/2)}";
        
        resizedWidget.setAttribute("transform", "matrix");
        resizedWidget.attributes["y"] = "${y + (SIZE/2)}"; 
        break;

    }
  }

  void setAnchorPosition(AnchorPosition position, double widgetX, double widgetY) {

    SvgElement anchor = anchors[position];

    double widgetW = double.parse(resizedWidget.attributes["width"]);
    double widgetH = double.parse(resizedWidget.attributes["height"]);

    switch (position) {

      case AnchorPosition.TOP:
        anchor.attributes["x"] = "${widgetX + (widgetW / 2) - (SIZE/2)}";
        anchor.attributes["y"] = "${widgetY - (SIZE/2)}";

        break;
      case AnchorPosition.BOTTOM:
        anchor.attributes["x"] = "${widgetX + (widgetW / 2) - (SIZE/2)}";
        anchor.attributes["y"] = "${widgetY + widgetH - (SIZE/2)}";
        break;
      case AnchorPosition.LEFT:
        anchor.attributes["x"] = "${widgetX - (SIZE/2)}";
        anchor.attributes["y"] = "${widgetY + (widgetH / 2) - (SIZE/2)}";
        break;
      case AnchorPosition.RIGHT:
        anchor.attributes["x"] = "${widgetX + widgetW - (SIZE/2)}";
        anchor.attributes["y"] = "${widgetY + (widgetH / 2) - (SIZE/2)}";
        break;
      case AnchorPosition.TOP_LEFT:
        anchor.attributes["x"] = "${widgetX - (SIZE/2)}";
        anchor.attributes["y"] = "${widgetY - (SIZE/2)}";
        break;
      case AnchorPosition.TOP_RIGHT:
        anchor.attributes["x"] = "${widgetX + widgetW - (SIZE/2)}";
        anchor.attributes["y"] = "${widgetY - (SIZE/2)}";
        break;
      case AnchorPosition.BOTTOM_LEFT:
        anchor.attributes["x"] = "${widgetX - (SIZE/2)}";
        anchor.attributes["y"] = "${widgetY + widgetH - (SIZE/2)}";
        break;
      case AnchorPosition.BOTTOM_RIGHT:
        anchor.attributes["x"] = "${widgetX + widgetW - (SIZE/2)}";
        anchor.attributes["y"] = "${widgetY + widgetH - (SIZE/2)}";
        break;

    }
  }

}

class AnchorPosition {
  final _value;
  const AnchorPosition._internal(this._value);
  toString() => 'Enum.$_value';

  static const LEFT = const AnchorPosition._internal('LEFT');
  static const RIGHT = const AnchorPosition._internal('RIGHT');
  static const TOP = const AnchorPosition._internal('TOP');
  static const BOTTOM = const AnchorPosition._internal('BOTTOM');
  static const TOP_LEFT = const AnchorPosition._internal('TOP_LEFT');
  static const TOP_RIGHT = const AnchorPosition._internal('TOP_RIGHT');
  static const BOTTOM_LEFT = const AnchorPosition._internal('BOTTOM_LEFT');
  static const BOTTOM_RIGHT = const AnchorPosition._internal('BOTTOM_RIGHT');
}
