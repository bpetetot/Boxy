part of boxy;

class SelectorManager {

  final BoxyView _BOXY;

  UserMode userMode;

  final List<Widget> _watchedWidgets = [];

  final Map<Widget, Selector> _widgetSelectors = {};

  final List<Widget> _selectedWidgets = [];

  final MultiSelector _multiSelector = new MultiSelector();

  SelectorManager(this._BOXY) {
    // Selector group ID
    _BOXY._SELECTORS_GROUP.attributes['id'] = "selectors-group";
    // Add Multiselector
    _multiSelector.attachMultiselector(_BOXY._SELECTORS_GROUP, _watchedWidgets);
    _multiSelector.onSelectBox.listen((e) => selectWidgets(e.selectedWidgets));
  }

  void registerWidget(Widget widget) {
    _watchedWidgets.add(widget);
    
    widget.onTranslate.listen((e) => _multiSelector.disabled());
    widget.onResize.listen((e) => _multiSelector.disabled());
    widget.onUpdate.listen((e) => _multiSelector.enable());
  }

  void selectWidgets(List<Widget> selectedWidgets) {
    _unselectWidgets();
    selectedWidgets.forEach((w) => _onSelectWidget(w));
  }

  void selectWidget(Widget selectedWidget) {
    if (_watchedWidgets.contains(selectedWidget)) {
      _unselectWidgets();
      _onSelectWidget(selectedWidget);
    }
  }

  void _unselectWidgets() {
    if (_selectedWidgets.isNotEmpty) {
      _selectedWidgets.forEach((w) => _widgetSelectors[w].hide());
      _selectedWidgets.clear();
    }
  }

  void _onSelectWidget(Widget selectedWidget) {
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
      _selectedWidgets.add(selectedWidget);
    }
  }

}
