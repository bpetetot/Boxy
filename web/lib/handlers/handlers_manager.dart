part of boxy;

class HandlersManager {

  final BoxyView _BOXY;

  final List<Widget> _watchedWidgets = [];

  final List<Widget> _handledWidgets = [];

  final MultiSelector _multiSelector = new MultiSelector();

  HandlersManager(this._BOXY) {
    // Selector group ID
    _BOXY._HANDLERS_GROUP.attributes['id'] = "handlers-group";
    // Add Multiselector
    _multiSelector.attachMultiselector(_BOXY._HANDLERS_GROUP, _watchedWidgets);
    _multiSelector.onSelectBox.listen((e) => handleWidgets(e.selectedWidgets));
  }

  void registerWidget(Widget widget) {
    _watchedWidgets.add(widget);

    widget.onTranslate.listen((e) => _multiSelector.disabled());
    widget.onResize.listen((e) => _multiSelector.disabled());
    widget.onUpdate.listen((e) => _multiSelector.enable());
  }

  void handleWidgets(List<Widget> widgets) {
    _unhandleWidgets();

    if (widgets.length > 1) {
      _multiSelector.displayHandler(widgets, _BOXY._HANDLERS_GROUP);
    } else {
      widgets.forEach((w) => _onHandleWidget(w));
    }
  }

  void _unhandleWidgets() {
    _multiSelector.hideHandler();

    if (_handledWidgets.isNotEmpty) {
      _handledWidgets.forEach((w) {
        w.toggleHandlers(_BOXY._HANDLERS_GROUP);

        w.onUnselect.add(new UnselectWidgetEvent(w));
      });
      _handledWidgets.clear();
    }
  }

  void _onHandleWidget(Widget widget) {
    if (_BOXY.userMode == UserMode.HANDLE_MODE && _watchedWidgets.contains(widget)) {
      widget.toggleHandlers(_BOXY._HANDLERS_GROUP);
      _handledWidgets.add(widget);

      widget.onSelect.add(new SelectWidgetEvent(widget));
    }
  }

}
