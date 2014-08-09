part of boxy;

class BoxyView {

  String viewId;
  SvgRenderer renderer;

  BoxyView(this.viewId, this.renderer);

  void display(Shape shape) {
    renderer.render(shape);
    renderer.displayGrid();
    renderer.attach(viewId);
  }

}
