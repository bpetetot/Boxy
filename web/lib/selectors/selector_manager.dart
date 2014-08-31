part of boxy;

class SelectorManager {

  final BoxyView _BOXY;

  UserMode userMode;

  final List<Widget> _watchedWidgets = [];

  final Map<Widget, Selector> _widgetSelectors = {};

  SelectorManager(this._BOXY) {
    // Selector group ID
    _BOXY._SELECTORS_GROUP.attributes['id'] = "selectors-group";
    // Unselect when the user click out of any widget
    _BOXY._SVG_ROOT.onClick.listen((e) => _unselectAll(e.offset.x, e.offset.y));
  }

  void registerWidget(Widget widget) {
    _watchedWidgets.add(widget);
    widget.element.onMouseDown.listen((e) => _onSelectWidget(widget));
  }

  void _onSelectWidget(Widget selectedWidget) {
    if (_watchedWidgets.contains(selectedWidget)) {
      _unselectWidgets();
      _selectWidget(selectedWidget);
    }
  }

  void _unselectWidgets() {
    if (_widgetSelectors.isNotEmpty) {
      _widgetSelectors.forEach((w, s) => s.hide());
    }
  }

  void _selectWidget(Widget selectedWidget) {
    if (_BOXY.userMode == UserMode.SELECT_MODE) {
      if (!_widgetSelectors.containsKey(selectedWidget)) {
        // create selectors
        Selector selector = new Selector(selectedWidget);
        selector.attach(_BOXY._SELECTORS_GROUP);
        selector.show();
        _widgetSelectors[selectedWidget] = selector;
      } else {
        _widgetSelectors[selectedWidget].show();
      }
    }
  }

  void _unselectAll(num x, num y) {

    bool intersect = false;
    for (Widget w in _watchedWidgets) {
      intersect = intersect || SvgUtils.intersect(x, y, w.element);
    }

    if (!intersect) {
      _unselectWidgets();
    }

  }


}
