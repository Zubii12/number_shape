import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  static const String _title = 'Number Shape';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: _title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _message = '';
  final TextEditingController _controller = TextEditingController();

  void _verifyNumber(int number) {
    if (number == null) {
      _message = 'Please enter a number';
      _showDialog();
      _controller.clear();
    } else if (_isSquare(number) && _isTriangle(number)) {
      _message = 'Number $number is both Square and Triangular';
      _showDialog();
      _controller.clear();
    } else if (_isSquare(number) && !_isTriangle(number)) {
      _message = 'Number $number is Square';
      _showDialog();
      _controller.clear();
    } else if (!_isSquare(number) && _isTriangle(number)) {
      _message = 'Number $number is Triangle';
      _showDialog();
      _controller.clear();
    } else {
      _message = 'Number $number is neither Square or Triangular';
      _showDialog();
      _controller.clear();
    }
  }

  bool _isSquare(int number) {
    return sqrt(number) == sqrt(number).toInt();
  }

  bool _isTriangle(int number) {
    return _isSquare((8 * number) + 1);
  }

  Future<void> _showDialog() async {
    final String number = _controller.text;
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(number),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(_message),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const Text(
              'Please input a number to see if it is square or triangle',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: _controller,
              decoration:
                  const InputDecoration(hintText: 'Please enter a number'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _verifyNumber(int.tryParse(_controller.text)),
        child: const Icon(Icons.check_sharp),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
