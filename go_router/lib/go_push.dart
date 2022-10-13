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
    final pages = GoRouter.of(context).routerDelegate.currentConfiguration.matches.reversed.toList();
    final pushBtnStyle = ElevatedButton.styleFrom(
      backgroundColor: Colors.greenAccent,
      foregroundColor: Colors.black,
    );
    return Center(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                constraints: const BoxConstraints(maxHeight: 150),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: pages.length,
                  itemExtent: 22,
                  itemBuilder: (context, index) {
                    final page = pages[index].fullUriString;
                    return Container(
                      color: Colors.primaries[index % Colors.primaries.length].withOpacity(.5),
                      alignment: Alignment.center,
                      child: Text(index == 0 ? 'CURRENT: $page' : page),
                    );
                  },
                ),
              ),
              if (pages.length > 3) Banner(message: 'Pages: ${pages.length}', location: BannerLocation.topEnd),
            ],
          ),
          Container(height: 20, color: Colors.primaries.last, alignment: Alignment.center, child: const Text('END')),
          ...[
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go to HOME screen'),
            ),
            ElevatedButton(
              style: pushBtnStyle,
              onPressed: () => context.push('/'),
              child: const Text('Push to HOME screen'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/first'),
              child: const Text('Go to FIRST screen'),
            ),
            ElevatedButton(
              style: pushBtnStyle,
              onPressed: () => context.push('/first'),
              child: const Text('Push to FIRST screen'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/second'),
              child: const Text('Go to SECOND screen'),
            ),
            ElevatedButton(
              style: pushBtnStyle,
              onPressed: () => context.push('/second'),
              child: const Text('Push to SECOND screen'),
            ),
          ].map((e) => Expanded(child: Center(child: e)))
        ],
      ),
    );
  }
}
