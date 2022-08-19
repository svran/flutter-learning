import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KeyTest extends StatefulWidget {
  KeyTest({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<KeyTest> {
  int _counter = 0;

  final incrementKeySet = LogicalKeySet(
    LogicalKeyboardKey.meta, // Replace with control on Windows
    LogicalKeyboardKey.arrowUp,
  );
  final decrementKeySet = LogicalKeySet(
    LogicalKeyboardKey.meta, // Replace with control on Windows
    LogicalKeyboardKey.arrowDown,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: CounterShortcuts(
        onIncrementDetected: _increment,
        onDecrementDetected: _decrement,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('code by Svran in 2022年8月19日', style: const TextStyle(fontSize: 40)),
              Text('$_counter', style: const TextStyle(fontSize: 48)),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: _increment, child: const Text('+1')),
                  const SizedBox(width: 24),
                  ElevatedButton(onPressed: _decrement, child: const Text('-1')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _increment() {
    _counter++;
    setState(() {});
  }

  void _decrement() {
    _counter--;
    setState(() {});
  }
}

final incrementKey = LogicalKeySet(
  LogicalKeyboardKey.control,
  LogicalKeyboardKey.arrowUp,
);

final decrementKey = LogicalKeySet(
  LogicalKeyboardKey.control,
  LogicalKeyboardKey.arrowDown,
);

class IncrementIntent extends Intent {}

class DecrementIntent extends Intent {}

class CounterShortcuts extends StatelessWidget {
  const CounterShortcuts({
    Key? key,
    required this.child,
    required this.onIncrementDetected,
    required this.onDecrementDetected,
  }) : super(key: key);

  final Widget child;
  final VoidCallback onIncrementDetected;
  final VoidCallback onDecrementDetected;

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      autofocus: true,
      shortcuts: {
        incrementKey: IncrementIntent(),
        decrementKey: DecrementIntent(),
      },
      actions: {
        IncrementIntent: CallbackAction(
          onInvoke: (_) => onIncrementDetected.call(),
        ),
        DecrementIntent: CallbackAction(
          onInvoke: (_) => onDecrementDetected.call(),
        ),
      },
      child: child,
    );
  }
}
