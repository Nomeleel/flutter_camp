import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  App({super.key});

  static const String title = 'GoRouter Camp: Same Path';

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: title,
    );
  }

  final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    routes: <GoRoute>[
      GoRoute(
        path: '/group/path',
        builder: (BuildContext context, GoRouterState state) => const PathScreen(path: '/group/path before(1)'),
      ),
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) => const HomeScreen(),
        routes: <GoRoute>[
          GoRoute(
            path: 'group/path',
            builder: (BuildContext context, GoRouterState state) => const PathScreen(path: '/  group/path after(2-1)'),
          ),
          GoRoute(
            path: 'group',
            builder: (BuildContext context, GoRouterState state) => const GroupScreen(),
            routes: <GoRoute>[
              GoRoute(
                path: 'path',
                builder: (BuildContext context, GoRouterState state) => const PathScreen(path: '/  group  path(2-2)'),
              ),
            ],
          ),
          GoRoute(
            path: 'group/path',
            builder: (BuildContext context, GoRouterState state) => const PathScreen(path: '/  group/path after(2-3)'),
          ),
        ],
      ),
      GoRoute(
        path: '/group/path',
        builder: (BuildContext context, GoRouterState state) => const PathScreen(path: '/group/path after(3)'),
      ),
    ],
  );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(App.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => context.go('/group'),
              child: const Text('Go to group screen'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/group/path'),
              child: const Text('Go to path screen'),
            ),
          ],
        ),
      ),
    );
  }
}

class GroupScreen extends StatelessWidget {
  const GroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Group screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => context.go('/group/path'),
              child: const Text('Go to path screen'),
            ),
            ElevatedButton(
              onPressed: () => context.push('/group/path'),
              child: const Text('Push to path screen'),
            ),
          ],
        ),
      ),
    );
  }
}

class PathScreen extends StatelessWidget {
  const PathScreen({super.key, required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Path: $path')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => context.go('/group'),
              child: const Text('Go to group screen'),
            ),
            ElevatedButton(
              onPressed: () => context.push('/group'),
              child: const Text('Push to group screen'),
            ),
          ],
        ),
      ),
    );
  }
}
