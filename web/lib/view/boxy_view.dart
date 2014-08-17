part of boxy;

class BoxyView {

  final SvgSvgElement _SVG_ROOT = new SvgSvgElement();

  final SvgSvgElement _SVG_BACKGROUND = new SvgSvgElement();

  final SvgSvgElement _SVG_CONTENT = new SvgSvgElement();

  final GElement _LAYERS_GROUP = new GElement();

  final GElement _SELECTORS_GROUP = new GElement();

  DevLogger logger;

  SelectorManager _selectorManager;
  ConnectorManager _connectorManager;

  int nbLayers = 0;

  final Map<String, SvgElement> _LAYERS = {};

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
    _SELECTORS_GROUP.attributes['id'] = "selectors-group";
    _SVG_CONTENT.append(_SELECTORS_GROUP);

    // Create the default layer
    addLayer('layer-1');

    // Append views to the root
    _SVG_ROOT.append(_SVG_BACKGROUND);
    _SVG_ROOT.append(_SVG_CONTENT);

    // Create the Selection Manager
    _selectorManager = new SelectorManager(_SELECTORS_GROUP);

    // Create the Connector Manager
    _connectorManager = new ConnectorManager(_SELECTORS_GROUP);

    querySelector(viewId).append(_SVG_ROOT);
  }

  void enableDevLogger(String viewId) {
    logger = new DevLogger(viewId);
    _SVG_ROOT.onMouseMove.listen((e) => logger.mouseOnContent(e));
  }

  void addWidget(Widget widget) {

    // attach the widget to the first layer
    if (_LAYERS.isNotEmpty) {
      widget.attach(_LAYERS.values.first);
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
      widget.attach(_LAYERS[layer]);
    } else {
      window.console.error("Layer '$layer' not found, you must create it before adding widgets.");
    }

  }

  void addLayer(String layer) {
    if (!_LAYERS.containsKey(layer)) {
      nbLayers++;
      GElement layerEl = new GElement();
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

    RectElement borders = new RectElement();
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
      LineElement line = new LineElement();
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
      LineElement line = new LineElement();
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
