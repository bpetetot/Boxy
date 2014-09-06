part of boxy;

class ConnectorManager {

  final BoxyView _BOXY;

  final List<Widget> _watchedWidgets = [];

  final GripConnector _gripConnector = new GripConnector();
  
  Widget currentWidget;
  ConnectorPath currentPath;

  ConnectorManager(this._BOXY) {
    // Add connector grip
    this._gripConnector.attach(_BOXY._CONNECTOR_GROUP, 0);
    this._gripConnector.element.onClick.listen((e) => onConnect(e.offset.x, e.offset.y));
  }

  void registerWidget(Widget widget) {
    if (widget.connectable) {
      this._watchedWidgets.add(widget);
      widget.element.onMouseOver.listen((e) => _onSelectWidget(widget));
    }
  }

  void _onSelectWidget(Widget selectedWidget) {
    if (_watchedWidgets.contains(selectedWidget) && currentWidget != selectedWidget) {
      this._displayConnector(selectedWidget);
    }
  }

  void _displayConnector(Widget selectedWidget) {
    if (_BOXY.userMode == UserMode.CONNECT_MODE) {
      this._gripConnector.dettachCurrentWidget();
      this._gripConnector.attachWidget(selectedWidget);
      this.currentWidget = selectedWidget;
      this.show();
    } else {
      this.hide();
    }
  }

  void show() {
    _BOXY._CONNECTOR_GROUP.attributes["display"] = "visible";
  }

  void hide() {
    _BOXY._CONNECTOR_GROUP.attributes["display"] = "none";
  }

  void onConnect(num x, num y) {
    
    if (currentPath == null) {
      // Create new connector
      this.currentPath = new ConnectorPath(_BOXY, currentWidget,  x, y);
    } else {
      // Finish the connector
      this.currentPath.connectTo(currentWidget, x, y);
      this.currentPath = null;
    }
    
  }


}
