

import 'lib/boxy.dart';

void main() {

  Shape shape = new Shape(10.0,10.0, 50.0, 20.0);

  BoxyView boxy = new BoxyView();
  boxy.attach("#viewport");
  boxy.displayGrid();
  boxy.display(shape);

}
