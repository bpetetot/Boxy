part of boxy;

// ---- Translate Listener

class TranslateListener extends ListenerBoxy {

  void notify(num dx, num dy) {
    super.apply(new TranslateEvent(dx, dy));
  }

  void onNotify(TranslateEvent event, dynamic notifier) {
    notifier(event.dx, event.dy);
  }

}

class TranslateEvent extends EventBoxy {

  num dx, dy;

  TranslateEvent(this.dx, this.dy);

}


// ---- Resize Listener

class ResizeListener extends ListenerBoxy {

  void notify(num dx, num dy) {
    super.apply(new ResizeEvent(dx, dy));
  }

  void onNotify(ResizeEvent event, dynamic notifier) {
    notifier(event.dx, event.dy);
  }

}

class ResizeEvent extends EventBoxy {

  num dx, dy;
  ResizeEvent(this.dx, this.dy);

}

// ---- Update Listener

class UpdateListener extends ListenerBoxy {

  void notify() {
    super.apply(new EventBoxy());
  }

  void onNotify(EventBoxy event, dynamic notifier) {
    notifier();
  }

}
