part of boxy;

class SelectorManager {

  final GElement _SELECTORS_VIEW;

  final List<Widget> _watchedWidgets = [];

  final Map<Widget, Selector> _widgetSelectors = {};

  SelectorManager(this._SELECTORS_VIEW) {
    _SELECTORS_VIEW.attributes['id'] = "selectors-group";
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
    if (!_widgetSelectors.containsKey(selectedWidget)) {
      // create selectors
      Selector selector = new Selector(selectedWidget);
      selector.attach(_SELECTORS_VIEW);
      _widgetSelectors[selectedWidget] = selector;
    } else {
      _widgetSelectors[selectedWidget].show();
    }
  }


}
