part of boxy;

class TextBoxy extends Widget {

  TextBoxy(String text, double x, double y, int size) {

    element = new svg.TextElement();
    element.attributes = {
      "x": "$x",
      "y": "$y",
      "font-size": "$size",
      "font-family": "Lucida Grande",
      "text-anchor": "middle",
      "vector-effect": "non-scaling-stroke"
    };
    element.text = text;

    subscribedEvents.add(element.onClick.listen((e) => createEditable()));

  }

  void createEditable() {

    print("click");

    svg.ForeignObjectElement _edition = new svg.ForeignObjectElement();
    _edition.attributes = {
      "x": "$x",
      "y": "$y",
      "width": "$width",
      "height": "$height"
    };

    var input = new InputElement(type: "text");
    input.value = element.text;
    _edition.append(input);

    subscribedEvents.add(input.onChange.listen((e) => element.text = input.value));

    parentSvg.append(_edition);
  }

  void attach(svg.SvgElement parent, int order) {
    super.attach(parent, order);

    svg.Rect bbox = SvgUtils.getBBox(element);
    x = bbox.x;
    y = bbox.y;
    width = bbox.width;
    height = bbox.height;
  }


  double get x => double.parse(element.attributes["x"]);

  double get cx => x + (width / 2);

  double get y => double.parse(element.attributes["y"]);

  double get cy => y + (height / 2);

  double get width => double.parse(element.attributes["width"]);

  double get height => double.parse(element.attributes["height"]);

  set x(double x) => element.attributes["x"] = "$x";

  set y(double y) => element.attributes["y"] = "$y";

  set width(double width) => element.attributes["width"] = "$width";

  set height(double height) => element.attributes["height"] = "$height";


}
