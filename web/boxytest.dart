import 'lib/boxy.dart';

import 'dart:html';

void main() {

  BoxyView boxy = new BoxyView("#viewport");
  //boxy.displayGrid();
  boxy.enableDevLogger("#info");

  querySelector("#addSquare").onClick.listen((e) => addSquare(boxy));
  
  querySelector("#addEllipse").onClick.listen((e) => addEllipse(boxy));
  
  querySelector("#selectMode").onClick.listen((e) => boxy.userMode = UserMode.SELECT_MODE);
  
  querySelector("#connectMode").onClick.listen((e) => boxy.userMode = UserMode.CONNECT_MODE);
  
}

void addSquare(BoxyView boxy) {
  
  RectangleBoxy widget = new RectangleBoxy(10.0, 10.0, 200.0, 200.0);
  widget.dragable = true;
  widget.resizable = true;
  widget.connectable = true;
  boxy.addWidget(widget);

}


void addEllipse(BoxyView boxy) {
  
  EllipseBoxy widget = new EllipseBoxy(100.0, 100.0, 30.0, 30.0);
  widget.dragable = true;
  widget.resizable = true;
  widget.connectable = true;
  boxy.addWidget(widget);
  
}
