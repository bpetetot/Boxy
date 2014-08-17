part of boxy;

abstract class Widget {

  SvgElement element;

  bool resizable = false;

  bool dragable = false;

  double get x;

  double get cx;

  double get y;

  double get cy;

  double get width;

  double get height;

  void set x(double x);

  void set y(double y);

  void set width(double width);

  void set height(double height);

  // ---- SVG Methods
  
  SvgSvgElement get parentSvg => element.ownerSvgElement;
  
  SvgSvgElement get rootSvg => parentSvg.ownerSvgElement;

  // ---- Attach / Dettach

  void attach(SvgElement parent) {
    parent.append(element);
  }

  void dettach() {
    element.remove();
  }

  // ---- Boxy Events

  List<dynamic> translateListeners = [];

  void addTranslateListener(void onTranslate(x, y)) {
    translateListeners.add((x, y) => onTranslate(x, y));
  }

  List<dynamic> updateListeners = [];

  void addUpdateListener(void onUpdate(x, y)) {
    updateListeners.add((x, y) => onUpdate(x, y));
  }
  
  List<dynamic> resizeListeners = [];

  void addResizeListener(void onResize(x, y)) {
    resizeListeners.add((x, y) => onResize(x, y));
  }

  // ---- Widget transforms

  void translate(num dx, num dy) {
    element.attributes["transform"] = "translate(${dx}, ${dy})";

    for (dynamic listener in translateListeners) {
      listener(dx, dy);
    }
  }

  void scale(num dx, num dy) {
    
    num ratioX = ((width + dx) / width);
    num ratioY = ((height + dy) / height);

    num translateX = -x * (ratioX - 1);
    num translateY = -y * (ratioY - 1);
    element.attributes["transform"] = "translate(${translateX},${translateY}) scale(${ratioX}, ${ratioY})";
  
    for (dynamic listener in resizeListeners) {
      listener(dx, dy);
    }
  }

  void rotate(num angle) {

    num cx = x + (width / 2);
    num cy = y + (height / 2);

    element.attributes["transform"] = "rotate(${angle}, ${cx}, ${cy})";

  }

  void updateCoordinates() {
    
    var position = parentSvg.createSvgPoint();
    position.x = x;
    position.y = y;
    position = SvgUtils.coordinateTransform(position, element);

    var position2 = parentSvg.createSvgPoint();
    position2.x = x + width;
    position2.y = y + height;
    position2 = SvgUtils.coordinateTransform(position2, element);

    width = (position2.x - position.x).abs();
    height = (position2.y - position.y).abs();
    x = position.x;
    y = position.y;

    for (dynamic listener in updateListeners) {
      listener(x, y);
    }

    element.attributes["transform"] = "";
  }

}
