library boxy;

import 'dart:html';
import 'dart:svg';
import 'dart:math' hide Point ;

part './view/boxy_view.dart';

part './utils/math_utils.dart';

part './handlers/handler.dart';
part './handlers/drag_handler.dart';
part './handlers/resize_handler.dart';

part './selectors/selector_manager.dart';
part './selectors/selector.dart';
part './selectors/rubber.dart';
part './selectors/grip_resize.dart';
part './selectors/grip_rotate.dart';

part './widgets/widget.dart';
part './widgets/anchor.dart';
part './widgets/rectangle.dart';
part './widgets/ellipse.dart';