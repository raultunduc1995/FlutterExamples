import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Demo App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _descriptionText = 'Flutter for Android Devs';

  void _sayHi() {
    setState(() {
      _descriptionText = 'Hi! Flutter here!';
    });
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            _descriptionText,
            style: const TextStyle(fontSize: 20),
          ),
          CustomButton(
            text: 'Hi',
            onPressed: _sayHi,
          ),
        ],
      ),
    );
  }

  void _updateDescriptionText() {
    setState(() {
      _descriptionText = 'Flutter is awesome!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _updateDescriptionText,
        tooltip: 'Update description',
        child: const Icon(Icons.autorenew),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  CustomButton({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: Theme.of(context).textTheme.button,
        ));
  }
}
