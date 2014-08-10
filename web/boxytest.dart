

import 'lib/boxy.dart';

void main() {

  RectangleBoxy widget = new RectangleBoxy(10.0,10.0, 50.0, 20.0);

  BoxyView boxy = new BoxyView("#viewport");
  boxy.displayGrid();
  boxy.addWidget(widget);
  
  CircleBoxy widget2 = new CircleBoxy(50.0,50.0, 10.0);
  boxy.addWidget(widget2);

}
