String originalPath = "M40 20 C40 31.0457 31.0457 40 20 40 C8.9543 40 0 31.0457 0 20 C0 8.9543 8.9543 0 20 0 C31.0457 0 40 8.9543 40 20 ZM20 40 L20 75M20 75 L0 105M20 75 L40 105M2 60 L38 60";

List<String> commands = ["M", "L", "H", "V", "C", "S", "Q", "T", "A", "Z"];

// M x y                    m dx dy
// L x y                    l dx dy
// H x                      h dx
// V y                      v dy
// Z                        z
// C x1 y1, x2 y2, x y      c dx1 dy1, dx2 dy2, dx dy
// S x2 y2, x y             s dx2 dy2, dx dy
// Q x1 y1, x y             q dx1 dy1, dx dy
// T x y                    t dx dy
// A rx ry x-axis-rotation large-arc-flag sweep-flag x y     a rx ry x-axis-rotation large-arc-flag sweep-flag dx dy

void main() {

  String sanitized = sanitizePath(originalPath);

  String result = sanitized.split(" ").map((e) => treatPathSingleElement(e)).reduce((s1, s2) => "$s1 $s2");
  print("$result");

}

String sanitizePath(String path) {
  path = path.replaceAll(",", " ");
  String newPath = "";
  for (int x = 0; x < path.length; x++) {
    String value = path[x];
    if (commands.contains(value)) {
      value = " >$value ";
    }
    newPath += value;
  }

  return newPath.split(">").map((e) => treatPathElement(e)).reduce((s1, s2) => "$s1 $s2");
}

String treatPathElement(String e) {
  List<String> elements = e.trim().split(" ");
  
  String command = elements.first;
  String transformedElement = e;
  
  if ((command == "M" || command == "L" || command == "T") && elements.length == 3) {
    num x = double.parse(elements[1]);
    num y = double.parse(elements[2]);
    transformedElement = "$command $x $y";

  } else if (command == "H" && elements.length == 2) {
    num x = double.parse(elements[1]);
    num y = 0;
    transformedElement = "$command $x";
    
  } else if (command == "V" && elements.length == 1) {
    num x = 0;
    num y = double.parse(elements[2]);
    transformedElement = "$command $y";

  } else if ((command == "S" || command == "Q") && elements.length == 5) {
    num x1 = double.parse(elements[1]);
    num y1 = double.parse(elements[2]);
    num x2 = double.parse(elements[3]);
    num y2 = double.parse(elements[4]);
    transformedElement = "$command $x1 $y1 $x2 $y2";

  } else if (command == "C" && elements.length == 7) {
    num x1 = double.parse(elements[1]);
    num y1 = double.parse(elements[2]);
    num x2 = double.parse(elements[3]);
    num y2 = double.parse(elements[4]);
    num x3 = double.parse(elements[5]);
    num y3 = double.parse(elements[6]);
    transformedElement = "$command $x1 $y1 $x2 $y2 $x3 $y3";

  } else if (command == "A" && elements.length == 8) {
    num rx = double.parse(elements[1]);
    num ry = double.parse(elements[2]);
    num xr = double.parse(elements[3]);
    num lf = double.parse(elements[4]);
    num sf = double.parse(elements[5]);
    num x = double.parse(elements[6]);
    num y = double.parse(elements[7]);
    transformedElement = "$command $rx $ry $xr $lf $sf $x $y";
  }

  return transformedElement;
}

bool isNumeric(String value) {
  try {
    int numeric = num.parse(value);

  } on TypeError catch (e) {
    return true;
  } on FormatException catch (e) {
    return false;
  }
  return true;
}


String treatPathSingleElement(String e) {
  if (isNumeric(e)) {
    return "${double.parse(e.trim()) + 1.0}";
  } else {
    return e.trim();
  }
}
