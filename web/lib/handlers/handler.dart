part of boxy;

abstract class WidgetHandler {
  
  String name;
  
  WidgetHandler(this.name);
  
  void register(Widget widget, [dynamic callback]);
  
}