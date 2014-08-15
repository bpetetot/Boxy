part of boxy;

abstract class Widget {

  SvgElement element;

  bool resizable;

  bool dragable;

  double get x;

  double get y;

  double get width;

  double get height;

  void set x(double x);

  void set y(double y);

  void set width(double width);

  void set height(double height);

  SvgSvgElement get svg => element.ownerSvgElement;

  void attach(SvgElement parent) {
    parent.append(element);
  }

  void dettach() {
    element.remove();
  }

  void translate(num dx, num dy) {
    element.attributes["transform"] = "translate(${dx}, ${dy})";
  }

  void scale(num dx, num dy) {
    num ratioX = ((width + dx) / width);
    num ratioY = ((height + dy) / height);

    num translateX = -x * (ratioX - 1);
    num translateY = -y * (ratioY - 1);
    element.attributes["transform"] = "translate(${translateX},${translateY}) scale(${ratioX}, ${ratioY})";
  }

  void rotate(num degrees) {
    element.attributes["transform"] = "rotate(${degrees})";
  }

  void updateCoordinates() {
    var matrix = element.getCtm();
    var position = svg.createSvgPoint();
    position.x = x;
    position.y = y;
    position = position.matrixTransform(matrix);

    var position2 = svg.createSvgPoint();
    position2.x = x + width;
    position2.y = y + height;
    position2 = position2.matrixTransform(matrix);

    width = (position2.x - position.x).abs();
    height = (position2.y - position.y).abs();
    x = position.x;
    y = position.y;


    element.attributes["transform"] = "";
  }

}
