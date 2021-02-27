import 'package:flutter/material.dart';

void main() => runApp(MyApp('Flutter Transition'));

class MyApp extends StatelessWidget {
  MyApp(this._title);

  final String _title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Transition',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: _title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController _controller;
  CurvedAnimation _curve;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    _curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _fadeIn() {
    _controller
      ..reset()
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          child: FadeTransition(
            opacity: _curve,
            child: FlutterLogo(
              size: 100,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fadeIn,
        tooltip: 'Fade in',
        child: Icon(Icons.brush),
      ),
    );
  }
}
