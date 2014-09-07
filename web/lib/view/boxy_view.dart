part of boxy;

class BoxyView {

  final svg.SvgSvgElement _SVG_ROOT = new svg.SvgSvgElement();

  final svg.SvgSvgElement _SVG_BACKGROUND = new svg.SvgSvgElement();

  final svg.SvgSvgElement _SVG_CONTENT = new svg.SvgSvgElement();

  final svg.GElement _LAYERS_GROUP = new svg.GElement();

  final svg.GElement _HANDLERS_GROUP = new svg.GElement();
  
  final svg.GElement _CONNECTOR_GROUP = new svg.GElement();
  
  int orderIndex = 0;

  DevLogger logger;

  // Managers
  HandlersManager _selectorManager;
  ConnectorManager _connectorManager;
  
  // User Mode (select mode, connection mode)
  UserMode userMode = UserMode.HANDLE_MODE;
  
  
  int nbLayers = 0;

  final Map<String, svg.SvgElement> _LAYERS = {};

  final Map<String, String> _VIEW_ATTRS = {
    'width': '100%',
    'height': '500',
    'shape-rendering': 'auto'
  };

  BoxyView(String viewId) {
    // Create SVG views
    _SVG_ROOT.attributes = _VIEW_ATTRS;
    _SVG_ROOT.attributes['id'] = "svg-root";

    _SVG_BACKGROUND.attributes = _VIEW_ATTRS;
    _SVG_BACKGROUND.attributes['id'] = "svg-bg";

    _SVG_CONTENT.attributes = _VIEW_ATTRS;
    _SVG_CONTENT.attributes['id'] = "svg-content";

    // Add layers and selector groups to the content view
    _LAYERS_GROUP.attributes['id'] = "layers";
    _SVG_CONTENT.append(_LAYERS_GROUP);
    _HANDLERS_GROUP.attributes['id'] = "selectors-group";
    _SVG_CONTENT.append(_HANDLERS_GROUP);
    _SVG_CONTENT.append(_CONNECTOR_GROUP);

    // Create the default layer
    addLayer('layer-1');

    // Append views to the root
    _SVG_ROOT.append(_SVG_BACKGROUND);
    _SVG_ROOT.append(_SVG_CONTENT);

    // Create the Selection Manager
    _selectorManager = new HandlersManager(this);

    // Create the Connector Manager
    _connectorManager = new ConnectorManager(this);

    querySelector(viewId).append(_SVG_ROOT);
  }

  void enableDevLogger(String viewId) {
    logger = new DevLogger(viewId);
    _SVG_ROOT.onMouseMove.listen((e) => logger.mouseOnContent(e));
  }

  void addWidget(Widget widget) {

    // attach the widget to the first layer
    if (_LAYERS.isNotEmpty) {
      widget.attach(_LAYERS.values.first, orderIndex++);
    } else {
      window.console.error("No layers defined for the svg view.");
    }

    // Register widget to the selection manager
    _selectorManager.registerWidget(widget);
    _connectorManager.registerWidget(widget);

    // logger
    if (logger != null) {
      widget.element.onMouseMove.listen((e) => logger.onWidget(widget, e));
    }

  }


  void addWidgetToLayer(Widget widget, String layer) {

    // attach the widget to the given layer
    if (_LAYERS.containsKey(layer)) {
      widget.attach(_LAYERS[layer], orderIndex++);
    } else {
      window.console.error("Layer '$layer' not found, you must create it before adding widgets.");
    }

  }

  void addLayer(String layer) {
    if (!_LAYERS.containsKey(layer)) {
      nbLayers++;
      svg.GElement layerEl = new svg.GElement();
      layerEl.attributes['id'] = layer;
      // Add to the DOM
      _LAYERS_GROUP.append(layerEl);
      // Add to the map
      _LAYERS[layer] = layerEl;
    } else {
      window.console.error("Layer '$layer' already exists.");
    }
  }

  void removeLayer(String layer) {
    if (_LAYERS.containsKey(layer)) {
      nbLayers--;
      // Remove from the DOM
      _LAYERS[layer].remove();
      // Remove from the map
      _LAYERS.remove(layer);
    } else {
      window.console.error("Layer '$layer' doesn't exist.");
    }
  }
  
  void displayGrid() {

    final int step = 20;
    final num lineWidth = 0.1;
    final String lineColor = "grey";
    final num viewWidth = _SVG_BACKGROUND.ownerSvgElement.client.width;
    final num viewHeight = _SVG_BACKGROUND.ownerSvgElement.client.height;

    svg.RectElement borders = new svg.RectElement();
    borders.attributes = {
      "x": "0",
      "y": "0",
      "width": "${viewWidth}",
      "height": "${viewHeight}",
      "stroke": lineColor,
      "stroke-width": "${lineWidth}",
      "fill": "transparent"
    };
    _SVG_BACKGROUND.append(borders);

    for (int i = step; i < viewHeight; i = i + step) {
      svg.LineElement line = new svg.LineElement();
      line.attributes = {
        "x1": "0",
        "y1": "${i}",
        "x2": "${viewWidth}",
        "y2": "${i}",
        "stroke": lineColor,
        "stroke-width": "${lineWidth}"
      };
      _SVG_BACKGROUND.append(line);
    }

    for (int i = step; i < viewWidth; i = i + step) {
      svg.LineElement line = new svg.LineElement();
      line.attributes = {
        "x1": "${i}",
        "y1": "0",
        "x2": "${i}",
        "y2": "${viewHeight}",
        "stroke": lineColor,
        "stroke-width": "${lineWidth}"
      };
      _SVG_BACKGROUND.append(line);
    }

  }

}
