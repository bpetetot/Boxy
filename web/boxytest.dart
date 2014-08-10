import 'lib/boxy.dart';

void main() {

  BoxyView boxy = new BoxyView("#viewport");
  boxy.displayGrid();

  RectangleBoxy widget = new RectangleBoxy(10.0, 10.0, 50.0, 20.0);
  widget.draggable = true;
  widget.resizable = true;
  boxy.addWidget(widget);

  CircleBoxy widget2 = new CircleBoxy(50.0, 50.0, 10.0);
  widget2.draggable = true;
  widget2.resizable = true;
  boxy.addWidget(widget2);

}
