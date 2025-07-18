import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/theme_provider.dart';
import 'data/services/firebase_service.dart';
import 'widget_showcase_screen.dart';

void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await FirebaseService.initialize();

  // Run the app with Riverpod
  runApp(const ProviderScope(child: CocktailianApp()));
}

class CocktailianApp extends ConsumerWidget {
  const CocktailianApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeProvider);

    return MaterialApp(
      title: 'Cocktailian',
      theme: currentTheme.themeData,
      home: const WidgetShowcaseScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CocktailianHomePage extends StatefulWidget {
  const CocktailianHomePage({super.key});

  @override
  State<CocktailianHomePage> createState() => _CocktailianHomePageState();
}

class _CocktailianHomePageState extends State<CocktailianHomePage> {
  bool _firebaseConnected = false;

  @override
  void initState() {
    super.initState();
    _testFirebaseConnection();
  }

  Future<void> _testFirebaseConnection() async {
    final connected = await FirebaseService().testConnection();
    if (mounted) {
      setState(() {
        _firebaseConnected = connected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cocktailian')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.local_bar,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 24),
            Text(
              'Welcome to Cocktailian',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'Discover cocktails based on your ingredients',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _firebaseConnected ? Icons.check_circle : Icons.error,
                  color: _firebaseConnected
                      ? Theme.of(context).colorScheme.tertiary
                      : Theme.of(context).colorScheme.error,
                ),
                const SizedBox(width: 8),
                Text(
                  _firebaseConnected
                      ? 'Firebase Connected'
                      : 'Firebase Connection Failed',
                  style: TextStyle(
                    color: _firebaseConnected
                        ? Theme.of(context).colorScheme.tertiary
                        : Theme.of(context).colorScheme.error,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () {
                // TODO: Navigate to ingredient inventory
              },
              child: const Text('Start Mixing'),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {
                // TODO: Navigate to recipe discovery
              },
              child: const Text('Browse Recipes'),
            ),
          ],
        ),
      ),
    );
  }
}
