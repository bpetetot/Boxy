part of boxy;

class ResizeHandler extends WidgetHandler {

  Widget _widget;
  AnchorBoxy _anchor;

  static final double _SIZE = 10.0;
  
  ResizeHandler() : super("resize") {}

  void register(Widget widget, [onResize()]) {
    _widget = widget;
    _widget.element.onMouseDown.listen((event) => addAnchor(event));
  }

  void addAnchor(MouseEvent e) {
    if (_anchor == null) {
      _anchor = new AnchorBoxy(_widget, _SIZE);
      _anchor.attach(_widget.toolsGroup);
    }
  }

  void updateAnchorPosition() {
    if (_anchor != null) {
      _anchor.updateAnchorPosition();
    }
  }

}
