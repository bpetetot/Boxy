part of boxy;

class HandlersManager {

  final BoxyView _BOXY;

  final List<Widget> _watchedWidgets = [];

  final List<Widget> _handledWidgets = [];

  final WidgetSelector _widgetSelector = new WidgetSelector();

  HandlersManager(this._BOXY) {
    // Handler group ID
    _BOXY._HANDLERS_GROUP.attributes['id'] = "handlers-group";

    // Add Widget Selector
    _widgetSelector.attachSelector(_BOXY._HANDLERS_GROUP, _watchedWidgets);
    _widgetSelector.onSelectBox.listen((e) => showWidgetsHandlers(e.selectedWidgets));

    // Change user mode handler
    _BOXY.onChangeUserMode.listen((e) => e.mode != UserMode.HANDLE_MODE ? _widgetSelector.disabled() : _widgetSelector.enable());
  }

  void registerWidget(Widget widget) {
    _watchedWidgets.add(widget);

    widget.onTranslate.listen((e) => _widgetSelector.disabled());
    widget.onResize.listen((e) => _widgetSelector.disabled());
    widget.onUpdate.listen((e) => _widgetSelector.enable());

    widget.widgetHandlers.attach(_BOXY._HANDLERS_GROUP);
  }

  void showWidgetsHandlers(List<Widget> widgets) {

    _widgetSelector.hideMoveHandler();

    // Hide previous displayed handlers
    if (_handledWidgets.isNotEmpty) {
      _handledWidgets.forEach((w) {
        w.widgetHandlers.disable();
        w.onUnselect.add(new UnselectWidgetEvent(w));
      });
      _handledWidgets.clear();
    }

    if (widgets.isNotEmpty) {
      _widgetSelector.showMoveHandler(widgets, _BOXY._HANDLERS_GROUP);

      widgets.forEach((w) {
          if (widgets.length == 1) {
            w.widgetHandlers.enable();
          }
          _handledWidgets.add(w);
          w.onSelect.add(new SelectWidgetEvent(w));
      });
    }

  }


}
