import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO move to another file
class ConceptProvider with ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }
}

class ExampleProvider {
  String getData() {
    return 'Hello from ExampleProvider!';
  }
}

class ColorNotifier extends Notifier<Color> {
  @override
  build() {
    return Colors.black;
  }

  void changeColor() {
    state = state == Colors.black ? Colors.red : Colors.black;
  }
}

final colorProvider = NotifierProvider<ColorNotifier, Color>(() {
  return ColorNotifier();
});

// ***************** UI STARTS HERE *****************
void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return provider.MultiProvider(
      providers: [
        provider.ChangeNotifierProvider(create: (_) => ConceptProvider()),
        provider.Provider<ExampleProvider>(create: (_) => ExampleProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conceptProvider = provider.Provider.of<ConceptProvider>(context);
    final colorController = ref.watch(colorProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${conceptProvider.counter}',
              // style: Theme.of(context).textTheme.titleLarge,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: ref
                        .read(colorProvider.notifier)
                        .state, // Set the text color to pink
                  ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          conceptProvider.increment();
          ref.read(colorProvider.notifier).changeColor();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
