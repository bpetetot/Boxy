part of boxy;

List<String> commands = ["M", "L", "H", "V", "C", "S", "Q", "T", "A", "Z"];

String transformPath(String path, svg.SvgElement element) {
  path = path.replaceAll(",", " ");
  String newPath = "";
  for (int x = 0; x < path.length; x++) {
    String value = path[x];
    if (commands.contains(value)) {
      value = " >$value ";
    }
    newPath += value;
  }
  return newPath.split(">").map((e) => transformPathElement(e, element)).reduce((s1, s2) => "$s1 $s2");
}

String transformPathElement(String e, svg.SvgElement element) {

  List<String> elements = e.trim().split(" ").where((s) => s.trim() != "").toList();

  if (elements.isNotEmpty) {

    String command = elements.first.trim();
    String transformedElement = e.trim();

    if ((command == "M" || command == "L" || command == "T") && elements.length == 3) {
      num x = double.parse(elements[1]);
      num y = double.parse(elements[2]);

      var pt = SvgUtils.coordinateTransform(x, y, element);
      transformedElement = "$command ${pt.x} ${pt.y}";

    } else if (command == "H" && elements.length == 2) {
      num x = double.parse(elements[1]);
      num y = 0;

      var pt = SvgUtils.coordinateTransform(x, y, element);
      transformedElement = "$command ${pt.x}";

    } else if (command == "V" && elements.length == 1) {
      num x = 0;
      num y = double.parse(elements[2]);

      var pt = SvgUtils.coordinateTransform(x, y, element);
      transformedElement = "$command ${pt.y}";

    } else if ((command == "S" || command == "Q") && elements.length == 5) {
      num x1 = double.parse(elements[1]);
      num y1 = double.parse(elements[2]);
      num x2 = double.parse(elements[3]);
      num y2 = double.parse(elements[4]);

      var pt1 = SvgUtils.coordinateTransform(x1, y1, element);
      var pt2 = SvgUtils.coordinateTransform(x2, y2, element);
      transformedElement = "$command ${pt1.x} ${pt1.y} ${pt2.x} ${pt2.y}";

    } else if (command == "C" && elements.length == 7) {
      num x1 = double.parse(elements[1]);
      num y1 = double.parse(elements[2]);
      num x2 = double.parse(elements[3]);
      num y2 = double.parse(elements[4]);
      num x3 = double.parse(elements[5]);
      num y3 = double.parse(elements[6]);

      var pt1 = SvgUtils.coordinateTransform(x1, y1, element);
      var pt2 = SvgUtils.coordinateTransform(x2, y2, element);
      var pt3 = SvgUtils.coordinateTransform(x3, y3, element);
      transformedElement = "$command ${pt1.x} ${pt1.y} ${pt2.x} ${pt2.y} ${pt3.x} ${pt3.y}";

    } else if (command == "A" && elements.length == 8) {
      num rx = double.parse(elements[1]);
      num ry = double.parse(elements[2]);
      num xr = double.parse(elements[3]);
      num lf = double.parse(elements[4]);
      num sf = double.parse(elements[5]);
      num x = double.parse(elements[6]);
      num y = double.parse(elements[7]);

      var pt1 = SvgUtils.coordinateTransform(rx, ry, element);
      var pt2 = SvgUtils.coordinateTransform(xr, 0, element);
      var pt3 = SvgUtils.coordinateTransform(x, y, element);
      transformedElement = "$command ${pt1.x} ${pt1.y} ${pt2.x} $lf $sf ${pt3.x} ${pt3.y}";
    }
    return transformedElement.trim();
  } else {
    return "";
  }

}
