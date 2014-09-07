part of boxy;

class LineBoxy extends Widget {


  LineBoxy(num x1, num y1, num x2, num y2) {
    element = new svg.LineElement();

    element.attributes = {
      "x1": "$x1",
      "y1": "$y1",
      "x2": "$x2",
      "y2": "$y2",
      "stroke": "black",
      "stroke-width": "0.5",
      "vector-effect": "non-scaling-stroke"
    };

  }

  num get x => num.parse(element.attributes["x1"]);

  num get x2 => num.parse(element.attributes["x2"]);

  num get cx => x + (width / 2);

  num get y => num.parse(element.attributes["y1"]);

  num get y2 => num.parse(element.attributes["y2"]);

  num get cy => y + (height / 2);

  num get width => x2 - x;

  num get height => y2 - y;

  set x(num x) => element.attributes["x1"] = "$x";

  set y(num y) => element.attributes["y1"] = "$y";

  set x2(num x) => element.attributes["x2"] = "$x";

  set y2(num y) => element.attributes["y2"] = "$y";

  set width(num width) => x2 = width + x;

  set height(num height) => y2 = height + y;

  void updateCoordinates() {
    var position = SvgUtils.coordinateTransform(x, y, element);
    var position2 = SvgUtils.coordinateTransform(x + width, y + height, element);

    x = position.x;
    y = position.y;
    y2 = position2.y;
    x2 = position2.x;

    element.attributes["transform"] = "";

    onUpdate.add(new UpdateEvent());

  }

}
