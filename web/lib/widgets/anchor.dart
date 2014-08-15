part of boxy;

class AnchorBoxy extends RectangleBoxy {

  Widget _parent;
  
  static final double _SIZE = 10.0;

  dynamic _resize;

  AnchorBoxy(Widget parent, this._resize()) : super(parent.x + parent.width, parent.y + parent.height, _SIZE, _SIZE) {
    _parent = parent;
    dragHandler = new DragHandler();
    dragHandler.dragCursor = "nwse-resize";
  }

  void onDrag(MouseEvent e) {
    _resize();
  }

}
