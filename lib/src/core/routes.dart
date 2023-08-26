
import 'package:vrouter/vrouter.dart';

import '../modules/feed/pages/feed_page.dart';

class Routes {
  static List<VRouteElement> get routes {
    return mainRoutes;
  }

  static List<VRouteElement> mainRoutes = [
    VWidget(
      path: '/feed',
      widget: const FeedPage(),
      transitionDuration: Duration.zero,
    ),
  ];
}