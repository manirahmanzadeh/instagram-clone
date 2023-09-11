import 'package:flutter/material.dart';
import 'package:instagram_clone/src/core/routes.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';

import '../utils/finstagram_theme.dart';
import 'localization.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <ChangeNotifierProvider<dynamic>>[
        ChangeNotifierProvider<LocaleProvider>(
          create: (_) => LocaleProvider(),
        ),
      ],
      child: const _App(),
    );
  }
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return VRouter(
      title: 'Finstagram',
      theme: FinstagramTheme.light,
      debugShowCheckedModeBanner: false,
      locale: context.watch<LocaleProvider>().locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      mode: VRouterMode.history,
      initialUrl: '/login1',
      routes: Routes.routes,
      buildTransition: (animation, _, child) => FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}
