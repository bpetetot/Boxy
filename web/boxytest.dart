import 'lib/boxy.dart';

import 'dart:html';

void main() {

  BoxyView boxy = new BoxyView("#viewport");
  //boxy.displayGrid();
  boxy.enableDevLogger("#info");

  querySelector("#addSquare").onClick.listen((e) => boxy.addWidget(createSquare()));

  querySelector("#addEllipse").onClick.listen((e) => boxy.addWidget(createEllipse()));

  querySelector("#addPath").onClick.listen((e) => boxy.addWidget(createPath()));

  querySelector("#addCompose").onClick.listen((e) => boxy.addWidget(createCompose()));

  querySelector("#selectMode").onClick.listen((e) => boxy.changeUserMode(UserMode.HANDLE_MODE));

  querySelector("#connectMode").onClick.listen((e) => boxy.changeUserMode(UserMode.CONNECT_MODE));

}

Widget createSquare() {
  RectangleBoxy widget = new RectangleBoxy(1.0, 1.0, 40.0, 40.0);
  widget.addResizeHandler();
  widget.connectable = true;
  widget.onSelect.listen((w) => print("Select : $w"));
  widget.onUnselect.listen((w) => print("Unselect : $w"));

  return widget;
}


Widget createEllipse() {
  EllipseBoxy widget = new EllipseBoxy(40.0, 40.0, 20.0, 20.0);
  widget.addResizeHandler();
  widget.connectable = true;

  return widget;
}

Widget createPath() {
  PathBoxy widget = new PathBoxy(100.0, 100.0, 40.0, 40.0);
  widget.addResizeHandler();
  widget.connectable = true;

  return widget;
}

Widget createCompose() {
  ComposedWidgetBoxy widget = new ComposedWidgetBoxy(100.0, 100.0, 200.0, 200.0);
  widget.addResizeHandler();
  widget.connectable = true;

  widget.addChild(new RectangleBoxy(1.0, 1.0, 40.0, 40.0));
  widget.addChild(new EllipseBoxy(1.0, 40.0, 20.0, 20.0));
  widget.addChild(new PathBoxy(20.0, 100.0, 40.0, 100.0));

  return widget;
}
