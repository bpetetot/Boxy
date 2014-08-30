part of boxy;

abstract class Widget {

  svg.SvgElement element;

  bool resizable = false;

  bool dragable = false;

  bool connectable = false;

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

  svg.SvgSvgElement get parentSvg => element.ownerSvgElement;

  svg.SvgSvgElement get rootSvg => parentSvg.ownerSvgElement;

  // ---- Attach / Dettach

  void attach(svg.SvgElement parent) {
    parent.append(element);
  }

  void dettach() {
    element.remove();
    // cancel listeners
    subscribedEvents.forEach((e) => e.cancel());
  }

  // ---- Widget listeners
  List subscribedEvents = [];
  
  static final EventBoxyStreamProvider<TranslateEvent> translateEvent = new EventBoxyStreamProvider<TranslateEvent>('translate');
  static final EventBoxyStreamProvider<ResizeEvent> resizeEvent = new EventBoxyStreamProvider<ResizeEvent>('resize');
  static final EventBoxyStreamProvider<UpdateEvent> updateEvent = new EventBoxyStreamProvider<UpdateEvent>('update');

  EventBoxyStream<TranslateEvent> get onTranslate => translateEvent.forWidget(this);
  EventBoxyStream<ResizeEvent> get onResize => resizeEvent.forWidget(this);
  EventBoxyStream<UpdateEvent> get onUpdate => updateEvent.forWidget(this);

  // ---- Widget transforms

  void translate(num dx, num dy) {
    // translate the widget
    element.attributes["transform"] = "translate(${dx}, ${dy})";
    // notify listeners
    onTranslate.add(new TranslateEvent(dx, dy));
  }

  void scale(num dx, num dy) {
    // scale the widget
    num ratioX = (width + dx) / width;
    num ratioY = (height + dy) / height;

    if (ratioX < 0) ratioX = 0.02;
    if (ratioY < 0) ratioY = 0.02;

    num translateX = -x * (ratioX - 1);
    num translateY = -y * (ratioY - 1);


    element.attributes["transform"] = "translate(${translateX},${translateY}) scale(${ratioX}, ${ratioY})";

    // notify listeners
    onResize.add(new ResizeEvent(dx, dy));

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

    // notify listeners
    onUpdate.add(new UpdateEvent());

    element.attributes["transform"] = "";
  }

}
