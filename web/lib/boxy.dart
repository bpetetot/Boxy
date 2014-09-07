library boxy;

import 'dart:html';
import 'dart:svg' as svg;
import 'dart:math' as math;
import 'dart:async';

part 'view/boxy_view.dart';
part 'view/user_modes.dart';

part 'utils/math_utils.dart';
part 'utils/svg_utils.dart';
part 'utils/loggers.dart';
part 'utils/path_transform.dart';

part 'events/events_stream.dart';

part 'handlers/handlers_manager.dart';
part 'handlers/handler.dart';
part 'handlers/handler_resize.dart';
part 'handlers/handler_rotate.dart';
part 'handlers/widget_selector.dart';
part 'handlers/handler_move.dart';

part 'connectors/connector_manager.dart';
part 'connectors/connector_path.dart';
part 'connectors/grip_connector.dart';

part 'widgets/widget.dart';
part 'widgets/line.dart';
part 'widgets/rectangle.dart';
part 'widgets/ellipse.dart';
part 'widgets/path.dart';
part 'widgets/text.dart';
part 'widgets/composed_widget.dart';