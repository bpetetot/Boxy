import 'lib/boxy.dart';

import 'dart:html';

void main() {

  BoxyView boxy = new BoxyView("#viewport");
  boxy.displayGrid();

  querySelector("#addSquare").onClick.listen((e) => addSquare(boxy));
  
  querySelector("#addEllipse").onClick.listen((e) => addEllipse(boxy));

}

void addSquare(BoxyView boxy) {
  
  RectangleBoxy widget = new RectangleBoxy(10.0, 10.0, 200.0, 200.0);
  widget.dragable = true;
  widget.resizable = true;
  boxy.addWidget(widget);

}


void addEllipse(BoxyView boxy) {
  
  EllipseBoxy widget = new EllipseBoxy(100.0, 100.0, 30.0, 30.0);
  widget.dragable = true;
  widget.resizable = true;
  boxy.addWidget(widget);
  
}