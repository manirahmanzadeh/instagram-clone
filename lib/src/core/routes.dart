import 'package:instagram_clone/src/modules/comments/pages/comments_page.dart';
import 'package:instagram_clone/src/modules/explore/pages/search_page.dart';
import 'package:vrouter/vrouter.dart';

import '../modules/explore/pages/explore_page.dart';
import '../modules/feed/pages/feed_page.dart';
import '../modules/post_detail/pages/post_detail_page.dart';
import '../modules/story/pages/stories_page.dart';

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
                VWidget(
                  path: 'stories/:user_id',
                  widget: const StoriesPage(),
                ),
              ],
            ),
          ],
        ),
        VWidget(
          path: '/explore',
          widget: const ExplorePage(),
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
                  path: 'post_detail/:post_id',
                  widget: const PostDetailPage(),
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
                        VWidget(
                          path: 'stories/:user_id',
                          widget: const StoriesPage(),
                        ),
                      ],
                    ),
                  ],
                ),
                VWidget(
                  path: 'search',
                  widget: const SearchPage(),
                  stackedRoutes: [
                    VPopHandler(
                      onPop: (vRedirector) async =>
                          (vRedirector.historyCanBack())
                              ? vRedirector.historyBack()
                              : vRedirector.pop(),
                      onSystemPop: (vRedirector) async =>
                          (vRedirector.historyCanBack())
                              ? vRedirector.historyBack()
                              : vRedirector.pop(),
                      stackedRoutes: [
                        VWidget(
                          path: 'stories/:user_id',
                          widget: const StoriesPage(),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
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
