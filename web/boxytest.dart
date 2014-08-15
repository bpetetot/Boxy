import 'lib/boxy.dart';

void main() {

  BoxyView boxy = new BoxyView("#viewport");
  boxy.displayGrid();

  RectangleBoxy widget = new RectangleBoxy(10.0, 10.0, 200.0, 100.0);
  widget.dragable = true;
  widget.resizable = true;
  boxy.addWidget(widget);
  
  EllipseBoxy widget3 = new EllipseBoxy(200.0, 200.0, 10.0, 30.0);
  widget3.dragable = true;
  widget3.resizable = true;
  boxy.addWidget(widget3);

}
