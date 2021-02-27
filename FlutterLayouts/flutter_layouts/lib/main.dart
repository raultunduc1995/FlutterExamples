import 'package:flutter/material.dart';
import 'package:flutter_layouts/Components.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyPage(title: 'Flutter'),
    );
  }
}

class MyPage extends StatefulWidget {
  MyPage({this.title});

  final String title;

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  bool _renderRow = false;
  MainAxisSize _mainAxisSize = MainAxisSize.min;
  MainAxisAlignment _mainAxisAlignment = MainAxisAlignment.start;
  CrossAxisAlignment _crossAxisAlignment = CrossAxisAlignment.start;

  Widget _getAppBar() {
    return AppBar(
      title: Text(widget.title),
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.android),
          onPressed: () {},
        ),
      ],
      bottom: PreferredSize(
        preferredSize: Size(0, 330),
        child: Container(
          color: Colors.red,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Category(
                title: 'Orientation',
                options: [
                  SelectableButton(
                    text: 'Row',
                    isSelected: _renderRow,
                    onTap: () {
                      setState(() {
                        _renderRow = true;
                      });
                    },
                  ),
                  SelectableButton(
                    text: 'Column',
                    isSelected: !_renderRow,
                    onTap: () {
                      setState(() {
                        _renderRow = false;
                      });
                    },
                  )
                ],
              ),
              Category(
                title: 'Main Axis Size',
                options: [
                  SelectableButton(
                    text: 'Min',
                    isSelected: _mainAxisSize == MainAxisSize.min,
                    onTap: () {
                      setState(() {
                        _mainAxisSize = MainAxisSize.min;
                      });
                    },
                  ),
                  SelectableButton(
                    text: 'Max',
                    isSelected: _mainAxisSize == MainAxisSize.max,
                    onTap: () {
                      setState(() {
                        _mainAxisSize = MainAxisSize.max;
                      });
                    },
                  )
                ],
              ),
              Category(
                title: 'Main Axis Alignment',
                options: [
                  SelectableButton(
                    text: 'Start',
                    isSelected: _mainAxisAlignment == MainAxisAlignment.start,
                    onTap: () {
                      setState(() {
                        _mainAxisAlignment = MainAxisAlignment.start;
                      });
                    },
                  ),
                  SelectableButton(
                    text: 'Center',
                    isSelected: _mainAxisAlignment == MainAxisAlignment.center,
                    onTap: () {
                      setState(() {
                        _mainAxisAlignment = MainAxisAlignment.center;
                      });
                    },
                  ),
                  SelectableButton(
                    text: 'End',
                    isSelected: _mainAxisAlignment == MainAxisAlignment.end,
                    onTap: () {
                      setState(() {
                        _mainAxisAlignment = MainAxisAlignment.end;
                      });
                    },
                  ),
                  SelectableButton(
                    text: 'Evenly',
                    isSelected: _mainAxisAlignment == MainAxisAlignment.spaceEvenly,
                    onTap: () {
                      setState(() {
                        _mainAxisAlignment = MainAxisAlignment.spaceEvenly;
                      });
                    },
                  ),
                  SelectableButton(
                    text: 'Around',
                    isSelected: _mainAxisAlignment == MainAxisAlignment.spaceAround,
                    onTap: () {
                      setState(() {
                        _mainAxisAlignment = MainAxisAlignment.spaceAround;
                      });
                    },
                  ),
                  SelectableButton(
                    text: 'Between',
                    isSelected: _mainAxisAlignment == MainAxisAlignment.spaceBetween,
                    onTap: () {
                      setState(() {
                        _mainAxisAlignment = MainAxisAlignment.spaceBetween;
                      });
                    },
                  ),
                ],
              ),
              Category(
                title: 'Cross Axis Alignment',
                options: [
                  SelectableButton(
                    text: 'Start',
                    isSelected: _crossAxisAlignment == CrossAxisAlignment.start,
                    onTap: () {
                      setState(() {
                        _crossAxisAlignment = CrossAxisAlignment.start;
                      });
                    },
                  ),
                  SelectableButton(
                    text: 'Center',
                    isSelected: _crossAxisAlignment == CrossAxisAlignment.center,
                    onTap: () {
                      setState(() {
                        _crossAxisAlignment = CrossAxisAlignment.center;
                      });
                    },
                  ),
                  SelectableButton(
                    text: 'End',
                    isSelected: _crossAxisAlignment == CrossAxisAlignment.end,
                    onTap: () {
                      setState(() {
                        _crossAxisAlignment = CrossAxisAlignment.end;
                      });
                    },
                  ),
                  SelectableButton(
                    text: 'Stretch',
                    isSelected: _crossAxisAlignment == CrossAxisAlignment.stretch,
                    onTap: () {
                      setState(() {
                        _crossAxisAlignment = CrossAxisAlignment.stretch;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getContent() {
    if (_renderRow)
      return Row(
        mainAxisAlignment: _mainAxisAlignment,
        mainAxisSize: _mainAxisSize,
        crossAxisAlignment: _crossAxisAlignment,
        children: _getIcons(),
      );
    else
      return Column(
        mainAxisAlignment: _mainAxisAlignment,
        mainAxisSize: _mainAxisSize,
        crossAxisAlignment: _crossAxisAlignment,
        children: _getIcons(),
      );
  }

  List<Widget> _getIcons() {
    return const [
      Icon(
        Icons.android,
        size: 50,
      ),
      Icon(
        Icons.autorenew,
        size: 80,
      ),
      Icon(
        Icons.add,
        size: 50,
      ),
    ];
  }

  Widget _getDrawer() {
    return Drawer(
      child: ListView(
        children: const <Widget>[
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          Text('Item 1'),
          Text('Item 2'),
        ],
      ),
    );
  }

  Widget _getBottomNavigationBar() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      body: Container(
        color: Colors.yellow,
        child: _getContent(),
      ),
      drawer: _getDrawer(),
      bottomNavigationBar: _getBottomNavigationBar(),
    );
  }
}
