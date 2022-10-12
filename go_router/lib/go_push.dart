import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  App({super.key});

  static const String title = 'GoRouter Camp: Go Push';

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
        path: '/',
        builder: (BuildContext context, GoRouterState state) => const HomeScreen(),
        routes: <GoRoute>[
          GoRoute(
            path: 'first',
            builder: (BuildContext context, GoRouterState state) => const FirstScreen(),
          ),
          GoRoute(
            path: 'second',
            builder: (BuildContext context, GoRouterState state) => const SecondScreen(),
          ),
        ],
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
      body: const GoPushScreen(),
    );
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First screen')),
      body: const GoPushScreen(),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Screen')),
      body: const GoPushScreen(),
    );
  }
}

class GoPushScreen extends StatelessWidget {
  const GoPushScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = GoRouter.of(context).routerDelegate.currentConfiguration.matches;
    final pushBtnStyle = ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.greenAccent),
      foregroundColor: MaterialStateProperty.all(Colors.black),
    );
    return Center(
      child: Column(
        children: [
          Container(
            height: 100,
            color: Colors.purple.withOpacity(.7),
            child: ListView.builder(
              itemCount: pages.length,
              itemExtent: 22,
              itemBuilder: (context, index) => Container(
                color: Colors.primaries[index % Colors.primaries.length],
                alignment: Alignment.center,
                child: Text(pages[index].fullpath),
              ),
            ),
          ),
          ...[
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go to home screen'),
            ),
            ElevatedButton(
              style: pushBtnStyle,
              onPressed: () => context.push('/'),
              child: const Text('Push to home screen'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/first'),
              child: const Text('Go to first screen'),
            ),
            ElevatedButton(
              style: pushBtnStyle,
              onPressed: () => context.push('/first'),
              child: const Text('Push to first screen'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/second'),
              child: const Text('Go to second screen'),
            ),
            ElevatedButton(
              style: pushBtnStyle,
              onPressed: () => context.push('/second'),
              child: const Text('Push to second screen'),
            ),
          ].map((e) => Expanded(child: Center(child: e)))
        ],
      ),
    );
  }
}
