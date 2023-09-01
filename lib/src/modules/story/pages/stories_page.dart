import 'package:flutter/material.dart';
import 'package:instagram_clone/src/modules/story/providers/stories_provider.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';

import '../components/display/story_display.dart';
import '../components/indicators/indicators.dart';

class StoriesPage extends StatelessWidget {
  const StoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    String userId = context.vRouter.pathParameters['user_id'] ?? '';
    return ChangeNotifierProvider(
      create: (_) => StoriesProvider(
        context: context,
        userId: userId,
      ),
      child: const _StoriesPage(),
    );
  }
}

class _StoriesPage extends StatelessWidget {
  const _StoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StoriesProvider>();
    final staticProvider = context.read<StoriesProvider>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: provider.isLoadingStories
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white24,
                ),
              )
            : Stack(
                children: [
                  StoryDisplay(
                    stories: provider.user.stories,
                  ),
                  const StoryIndicators(),
                ],
              ),
      ),
    );
  }
}
