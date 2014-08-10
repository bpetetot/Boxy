part of boxy;

class ResizeHandler extends WidgetHandler {

  Widget _widget;
  AnchorBoxy _anchor;

  static final double _SIZE = 10.0;

  ResizeHandler() : super("resize") {}

  void register(Widget widget, [onResize()]) {
    _widget = widget;
    _widget.element.onMouseDown.listen((event) => _addAnchor(event));
  }

  void updateAnchorPosition() {
    if (_anchor != null) {
      _anchor.x = _widget.x + _widget.width;
      _anchor.y = _widget.y + _widget.height;
    }
  }
  
  void _addAnchor(MouseEvent e) {
    if (_anchor == null) {
      _anchor = new AnchorBoxy(_widget, _SIZE, () => _resize());
      _anchor.attach(_widget.toolsGroup);
    }
  }

  void _resize() {
    _anchor.x = max(_anchor.x, _widget.x);
    _anchor.y = max(_anchor.y, _widget.y);

    // Resize the element
    Point ptElement = _anchor.svg.createSvgPoint();
    ptElement.x = _anchor.x;
    ptElement.y = _anchor.y;

    ptElement = _widget.transformPointToElement(ptElement);

    _widget.width = max(ptElement.x - _widget.x, 1.0);
    _widget.height = max(ptElement.y - _widget.y, 1.0);
  }

}
