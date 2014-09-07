import 'lib/boxy.dart';

import 'dart:html';

String umlActor = "M40 20 C40 31.0457 31.0457 40 20 40 C8.9543 40 0 31.0457 0 20 C0 8.9543 8.9543 0 20 0 C31.0457 0 40 8.9543 40 20 ZM20 40 L20 75M20 75 L0 105M20 75 L40 105M2 60 L38 60";
String umlNode = "M0 0 L12 -20 L112 -20 L112 75 L95 95 L95 0 ZM95 0 L112 -20";

void main() {

  BoxyView boxy = new BoxyView("#viewport");
  boxy.enableDevLogger("#info");
  //boxy.displayGrid();

  querySelector("#addLine").onClick.listen((e) => boxy.addWidget(createLine()));

  querySelector("#addSquare").onClick.listen((e) => boxy.addWidget(createSquare()));

  querySelector("#addEllipse").onClick.listen((e) => boxy.addWidget(createEllipse()));

  querySelector("#addPath").onClick.listen((e) => boxy.addWidget(createPath()));

  querySelector("#addCompose").onClick.listen((e) => boxy.addWidget(createCompose()));

  querySelector("#selectMode").onClick.listen((e) => boxy.changeUserMode(UserMode.HANDLE_MODE));

  querySelector("#connectMode").onClick.listen((e) => boxy.changeUserMode(UserMode.CONNECT_MODE));

}

Widget createLine() {
  LineBoxy widget = new LineBoxy(1.0, 1.0, 40.0, 40.0)
      ..addResizeHandler()
      ..connectable = true
      ..onSelect.listen((w) => print("Select : $w"))
      ..onUnselect.listen((w) => print("Unselect : $w"));

  return widget;
}

Widget createSquare() {
  RectangleBoxy widget = new RectangleBoxy(1.0, 1.0, 40.0, 40.0)
      ..addResizeHandler()
      ..connectable = true
      ..onSelect.listen((w) => print("Select : $w"))
      ..onUnselect.listen((w) => print("Unselect : $w"));

  return widget;
}


Widget createEllipse() {
  EllipseBoxy widget = new EllipseBoxy(40.0, 40.0, 20.0, 20.0)
      ..addResizeHandler()
      ..connectable = true;

  return widget;
}

Widget createPath() {
  PathBoxy widget = new PathBoxy(umlActor, 100.0, 100.0, 40.0, 40.0)
      ..addResizeHandler()
      ..connectable = true;

  return widget;
}

Widget createCompose() {
  ComposedWidgetBoxy widget = new ComposedWidgetBoxy(100.0, 100.0, 200.0, 200.0)
      ..addResizeHandler()
      ..connectable = true
      ..addChild(new PathBoxy.fromPath(umlNode))
      ..addChild(new RectangleBoxy(0.0, 0.0, 95.0, 95.0))
      ..addChild(new TextBoxy("object", 47.0, 48.0, 11));

  //widget.addChild(new RectangleBoxy(0.0, 0.0, 150.0, 160.0));
  //widget.addChild(new LineBoxy(0.0, 30.0, 150.0, 30.0));

  return widget;
}
