part of boxy;

class BoxyView {

  final SvgSvgElement SVG = new SvgSvgElement();

  final int WIDTH = 800;
  final int HEIGHT = 600;

  BoxyView() {
    SVG.attributes = {
      'width': '${WIDTH}',
      'height': '${HEIGHT}'
    };
  }

  void attach(String viewId) {
    Element div = querySelector(viewId);
    div.append(SVG);
  }

  void display(Shape shape) {
    // Create Widget
    SvgElement widget = shape.createWidget(SVG);

    // Add widget to the SVG view
    SVG.append(widget);
  }

  void displayGrid() {

    int step = 20;

    for (int i = 0; i < HEIGHT; i = i + step) {
      SvgElement line = new SvgElement.tag("line");
      line.attributes = {
        "x1": "0",
        "y1": "${i}",
        "x2": "${WIDTH}",
        "y2": "${i}",
        "stroke": "grey",
        "stroke-width": "0.2"
      };
      SVG.append(line);
    }

    for (int i = 0; i < WIDTH; i = i + step) {
      SvgElement line = new SvgElement.tag("line");
      line.attributes = {
        "x1": "${i}",
        "y1": "0",
        "x2": "${i}",
        "y2": "${HEIGHT}",
        "stroke": "grey",
        "stroke-width": "0.2"
      };
      SVG.append(line);
    }

  }

}
