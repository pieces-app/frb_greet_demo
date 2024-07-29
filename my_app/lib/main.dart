import 'package:flutter/material.dart';
import 'package:my_app/src/rust/api/simple.dart';
import 'package:my_app/src/rust/frb_generated.dart';

Future<void> main() async {
  await RustLib.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('flutter_rust_bridge quickstart')),
        body: const GreetWidget(),
      ),
    );
  }
}

class GreetWidget extends StatefulWidget {
  const GreetWidget({super.key});

  @override
  _GreetWidgetState createState() => _GreetWidgetState();
}

class _GreetWidgetState extends State<GreetWidget> {
  final TextEditingController _controller = TextEditingController();
  String _greetResult = '';

  void _callGreet() async {
    final name = _controller.text;
    final result = await greet(name: name);
    setState(() {
      _greetResult = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Enter your name',
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _callGreet,
            child: const Text('Greet'),
          ),
          const SizedBox(height: 20),
          Text('Result: $_greetResult'),
        ],
      ),
    );
  }
}
