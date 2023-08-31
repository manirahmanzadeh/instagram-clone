import 'package:instagram_clone/src/modules/comments/pages/comments_page.dart';
import 'package:vrouter/vrouter.dart';

import '../modules/feed/pages/feed_page.dart';

class Routes {
  static List<VRouteElement> get routes {
    return mainRoutes + otherRoutes;
  }

  static List<VRouteElement> mainRoutes = [
    VPopHandler(
      onPop: (vRedirector) async => (vRedirector.historyCanBack())
          ? vRedirector.historyBack()
          : vRedirector.pop(),
      onSystemPop: (vRedirector) async => (vRedirector.historyCanBack())
          ? vRedirector.historyBack()
          : vRedirector.pop(),
      stackedRoutes: [
        VWidget(
          path: '/feed',
          widget: const FeedPage(),
          stackedRoutes: [
            VPopHandler(
              onPop: (vRedirector) async => (vRedirector.historyCanBack())
                  ? vRedirector.historyBack()
                  : vRedirector.pop(),
              onSystemPop: (vRedirector) async => (vRedirector.historyCanBack())
                  ? vRedirector.historyBack()
                  : vRedirector.pop(),
              stackedRoutes: [
                VWidget(
                  path: 'comments/:post_id',
                  widget: const CommentsPage(),
                ),
              ],
            ),
          ]
        ),
      ],
    ),
  ];

  static List<VRouteElement> otherRoutes = [
    VPopHandler(
      onPop: (vRedirector) async => (vRedirector.historyCanBack())
          ? vRedirector.historyBack()
          : vRedirector.pop(),
      onSystemPop: (vRedirector) async => (vRedirector.historyCanBack())
          ? vRedirector.historyBack()
          : vRedirector.pop(),
      stackedRoutes: [
        VWidget(
          path: '/comments/:post_id',
          widget: const CommentsPage(),
        ),
      ],
    ),
  ];
}
