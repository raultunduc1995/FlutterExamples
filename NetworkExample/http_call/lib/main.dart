import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp('Network Example'));

class MyApp extends StatelessWidget {
  MyApp(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: this.title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyPage(),
    );
  }
}

class MyPage extends StatefulWidget {
  MyPage({Key key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  List _widgets = [];
  final String url = 'https://jsonplaceholder.typicode.com/posts';

  @override
  void initState() {
    super.initState();
    _loadDataIsolated();
  }

  Future<void> _loadData() async {
    http.Response response = await http.get(url);

    setState(() {
      _widgets = jsonDecode(response.body);
    });
  }

  Future<void> _loadDataIsolated() async {
    ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(dataLoader, receivePort.sendPort);

    SendPort sendPort = await receivePort.first;
    ReceivePort secondReceivePort = ReceivePort();
    sendPort.send([url, secondReceivePort.sendPort]);
    List widgets = await secondReceivePort.first;

    setState(() {
      _widgets = widgets;
    });
  }

  static Future<void> dataLoader(SendPort sendPort) async {
    ReceivePort receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);
    await for (var msg in receivePort) {
      String data = msg[0];
      SendPort replyTo = msg[1];

      http.Response response = await http.get(data);
      replyTo.send(jsonDecode(response.body));
    }
  }

  Widget _getRow(int position) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Text('Row ${_widgets[position]['title']}'),
    );
  }

  Widget _getBody() {
    if (_widgets.length == 0) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView.builder(
        itemCount: _widgets.length,
        itemBuilder: (BuildContext _context, int i) => _getRow(i),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Network Page'),
      ),
      body: _getBody(),
    );
  }
}
