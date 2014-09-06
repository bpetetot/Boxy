part of boxy;

abstract class Widget {

  svg.SvgElement element;

  bool resizable = false;

  bool dragable = false;

  bool connectable = false;
  
  int order = 0;

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

  void attach(svg.SvgElement parent, int order) {
    this.order = order;
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
  static final EventBoxyStreamProvider<SelectWidgetEvent> selectEvent = new EventBoxyStreamProvider<SelectWidgetEvent>('select');
  static final EventBoxyStreamProvider<UnselectWidgetEvent> unselectEvent = new EventBoxyStreamProvider<UnselectWidgetEvent>('unselect');

  EventBoxyStream<TranslateEvent> get onTranslate => translateEvent.forWidget(this);
  EventBoxyStream<ResizeEvent> get onResize => resizeEvent.forWidget(this);
  EventBoxyStream<UpdateEvent> get onUpdate => updateEvent.forWidget(this);
  EventBoxyStream<SelectWidgetEvent> get onSelect => selectEvent.forWidget(this);
  EventBoxyStream<UnselectWidgetEvent> get onUnselect => unselectEvent.forWidget(this);
  
  // ---- Widget display
  void hide() {
    element.attributes["display"] = "none";
  }
  
  void show() {
    element.attributes["display"] = "visible";
  }

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

    var position = SvgUtils.coordinateTransform(x, y, element);
    var position2 = SvgUtils.coordinateTransform(x + width, y + height, element);

    width = (position2.x - position.x).abs();
    height = (position2.y - position.y).abs();
    x = position.x;
    y = position.y;

    // notify listeners
    onUpdate.add(new UpdateEvent());

    element.attributes["transform"] = "";
  }
  
  String toString() {
    return "($x, $y) $width $height";
  }

}
