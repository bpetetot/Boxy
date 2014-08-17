part of boxy;

abstract class ListenerBoxy {
  
  List<SubscribeEventBoxy> subscribeEvents = [];
  
  SubscribeEventBoxy listen(onNotify) {
    SubscribeEventBoxy subscribe = new SubscribeEventBoxy(onNotify);
    subscribeEvents.add(subscribe);
    return subscribe;
  }
  
  void apply(EventBoxy event) {
    
    List<SubscribeEventBoxy> toRemove = [];
    
    // Apply listeners
    for (var subscribeEvent in subscribeEvents) {
      if (subscribeEvent.active) {
        onNotify(event, subscribeEvent.notifier);
      } else {
        toRemove.add(subscribeEvent);
      }
    }
    
    // Remove canceled subscribers
    toRemove.forEach((s) => subscribeEvents.remove(s));
  }
  
  void onNotify(EventBoxy event, dynamic notifier);
  
}

class EventBoxy {
  
}

class SubscribeEventBoxy {
  
  bool active = true;
  
  dynamic notifier;
  
  SubscribeEventBoxy(this.notifier);
  
  void cancel() {
    active = false;
  }
  
}