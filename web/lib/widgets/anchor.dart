part of boxy;

class AnchorBoxy extends RectangleBoxy {

  Widget _parent;

  dynamic _resize;

  AnchorBoxy(Widget parent, double size, this._resize()) : super(parent.x + parent.width, parent.y + parent.height, size, size) {
    _parent = parent;
    dragHandler = new DragHandler();
    dragHandler.dragCursor = "nwse-resize";
  }

  void onDrag(MouseEvent e) {
    _resize();
  }

}
