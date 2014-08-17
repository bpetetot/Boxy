part of boxy;

class DevLogger {

  String viewId;

  MouseEvent contentEvent;
  Widget widget;
  MouseEvent widgetEvent;

  DevLogger(this.viewId);

  void onWidget(Widget widget, MouseEvent e) {
    this.widget = widget;
    this.widgetEvent = e;
    querySelector(viewId).setInnerHtml(getInfo());
  }

  void mouseOnContent(MouseEvent e) {
    contentEvent = e;
    querySelector(viewId).setInnerHtml(getInfo());
  }

  String getInfo() {

    String info = "";

    if (contentEvent != null) {
      String page = "page (${contentEvent.page.x}, ${contentEvent.page.y})";
      String offset = "offset (${contentEvent.offset.x}, ${contentEvent.offset.y})";

      info = "$page - $offset";
    }

    if (widget != null) {
      info += " / widget (${widget.x}, ${widget.y}, ${widget.width}, ${widget.height}) ";
    }

    if (widgetEvent != null) {

      var pagePt = widget.parentSvg.createSvgPoint();
      pagePt.x = widget.x;
      pagePt.y = widget.y;
      pagePt = SvgUtils.coordinateTransform(pagePt, widget.element);

      info += "=> (${pagePt.x},${pagePt.y})";

    }

    return info;
  }


}
