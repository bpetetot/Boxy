import 'lib/boxy.dart';

import 'dart:html';

void main() {

  BoxyView boxy = new BoxyView("#viewport");
  //boxy.displayGrid();
  boxy.enableDevLogger("#info");

  querySelector("#addSquare").onClick.listen((e) => addSquare(boxy));

  querySelector("#addEllipse").onClick.listen((e) => addEllipse(boxy));

  querySelector("#addShape").onClick.listen((e) => addShape(boxy));

  querySelector("#selectMode").onClick.listen((e) => boxy.userMode = UserMode.HANDLE_MODE);

  querySelector("#connectMode").onClick.listen((e) => boxy.userMode = UserMode.CONNECT_MODE);

}

void addSquare(BoxyView boxy) {

  RectangleBoxy widget = new RectangleBoxy(10.0, 10.0, 200.0, 200.0);
  widget.addMoveHandler();
  widget.addResizeHandler();
  widget.connectable = true;
  boxy.addWidget(widget);

  widget.onSelect.listen((w) => print("Select : $w"));
  widget.onUnselect.listen((w) => print("Unselect : $w"));
}


void addEllipse(BoxyView boxy) {

  EllipseBoxy widget = new EllipseBoxy(100.0, 100.0, 30.0, 30.0);
  widget.addMoveHandler();
  widget.addResizeHandler();
  widget.connectable = true;
  boxy.addWidget(widget);

}

void addShape(BoxyView boxy) {

  SvgShape widget = new SvgShape("actor", 100.0, 100.0, 100.0, 300.0);
  widget.addMoveHandler();
  widget.addResizeHandler();
  widget.connectable = true;
  boxy.addWidget(widget);

}
