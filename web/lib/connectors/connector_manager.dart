part of boxy;

class ConnectorManager {
  
  final GElement _CONNECTORS_VIEW;

  final List<Widget> _watchedWidgets = [];

  Widget currentWidget;
  
  final List<Connector> _widgetConnectors = [];
  
  ConnectorManager(this._CONNECTORS_VIEW) {
    _CONNECTORS_VIEW.attributes['id'] = "connectors-group";
  }

  void registerWidget(Widget widget) {
    _watchedWidgets.add(widget);
    widget.element.onMouseOver.listen((e) => _onSelectWidget(widget));
  }

  void _onSelectWidget(Widget selectedWidget) {
    if (_watchedWidgets.contains(selectedWidget)) {
      
      if (currentWidget != selectedWidget) {
        _hideConnectors();
        _displayConnectors(selectedWidget);
      }
    }
  }

  void _hideConnectors() {
    if (_widgetConnectors.isNotEmpty) {
      _widgetConnectors.forEach((c) => c.dettach());
      _widgetConnectors.clear();
    }
  }
  
  void _displayConnectors(Widget selectedWidget) {
    Connector connector = new Connector(selectedWidget, this);
    connector.attach(_CONNECTORS_VIEW);
    _widgetConnectors.add(connector);
  }
  
  ConnectorPath currentPath;
  
  void onConnect(Connector connector) {
    
    if (currentPath == null) {
      // Create new connector
      currentPath = new ConnectorPath(connector);
    } else {
      // Finish the connector
      currentPath.connectTo(connector);
      currentPath = null;
    }
    
  }


}