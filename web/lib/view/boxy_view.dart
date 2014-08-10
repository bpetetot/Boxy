part of boxy;

class BoxyView {

  final SvgSvgElement _SVG = new SvgSvgElement();

  BoxyView(String viewId) {
    _SVG.attributes = {
      'width': '100%',
      'height': '100%'
    };
    querySelector(viewId).append(_SVG);
  }

  void addWidget(Widget widget) {
    // attach the widget to the SVG view
    widget.attach(_SVG);
  }

  void displayGrid() {

    int step = 20;

    for (int i = 0; i < _SVG.client.height; i = i + step) {
      SvgElement line = new SvgElement.tag("line");
      line.attributes = {
        "x1": "0",
        "y1": "${i}",
        "x2": "${_SVG.client.width}",
        "y2": "${i}",
        "stroke": "grey",
        "stroke-width": "0.2"
      };
      _SVG.append(line);
    }

    for (int i = 0; i < _SVG.client.width; i = i + step) {
      SvgElement line = new SvgElement.tag("line");
      line.attributes = {
        "x1": "${i}",
        "y1": "0",
        "x2": "${i}",
        "y2": "${_SVG.client.height}",
        "stroke": "grey",
        "stroke-width": "0.2"
      };
      _SVG.append(line);
    }

  }

}
