import 'lib/boxy.dart';

void main() {

  BoxyView boxy = new BoxyView("#viewport");
  boxy.displayGrid();

  RectangleBoxy widget = new RectangleBoxy(10.0, 10.0, 50.0, 20.0);
  widget.dragHandler = new DragHandler();
  widget.resizeHandler = new ResizeHandler();
  boxy.addWidget(widget);

  CircleBoxy widget2 = new CircleBoxy(50.0, 50.0, 10.0);
  widget2.dragHandler = new DragHandler();
  widget2.resizeHandler = new ResizeHandler();
  
  boxy.addWidget(widget2);

}
