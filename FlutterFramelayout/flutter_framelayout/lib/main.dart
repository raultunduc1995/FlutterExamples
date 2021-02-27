import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  AlignmentDirectional _stackAlignment = AlignmentDirectional.topStart;
  AlignmentDirectional _yellowBlockAlignment = AlignmentDirectional.topStart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: PreferredSize(
          child: BottomContent(
            stackAlignment: _stackAlignment,
            yellowBlockAlignment: _yellowBlockAlignment,
            onStackAlignmentChanged: (AlignmentDirectional alignment) {
              setState(() {
                _stackAlignment = alignment;
              });
            },
            onYellowBlockAlignmentChanged: (AlignmentDirectional alignment) {
              setState(() {
                _yellowBlockAlignment = alignment;
              });
            },
          ),
          preferredSize: Size(0, 200),
        ),
      ),
      body: Container(
          color: Colors.grey.shade300,
          constraints: BoxConstraints.expand(),
          child: Stack(
            alignment: _stackAlignment,
            children: [
              Align(
                child: Container(
                  width: 200,
                  height: 200,
                  color: Colors.yellow,
                ),
                alignment: _yellowBlockAlignment,
              ),
              Positioned(
                child: Container(
                  width: 150,
                  height: 150,
                  color: Colors.red,
                ),
                bottom: 150,
                left: 80,
              ),
              Container(
                width: 100,
                height: 100,
                color: Colors.purple,
              ),
              Container(
                width: 75,
                height: 75,
                color: Colors.blue,
              ),
              Container(
                width: 50,
                height: 50,
                color: Colors.pink,
              ),
            ],
          )),
    );
  }
}

class BottomContent extends StatefulWidget {
  BottomContent({
    Key key,
    this.stackAlignment,
    this.yellowBlockAlignment,
    this.onStackAlignmentChanged,
    this.onYellowBlockAlignmentChanged,
  }) : super(key: key);

  final AlignmentDirectional stackAlignment;
  final AlignmentDirectional yellowBlockAlignment;
  final Function onStackAlignmentChanged;
  final Function onYellowBlockAlignmentChanged;

  @override
  _BottomContentState createState() => _BottomContentState();
}

class _BottomContentState extends State<BottomContent> {
  bool _isStackAlignmentSelected = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SelectableText(
                  'Stack Alignment',
                  isSelected: _isStackAlignmentSelected,
                  onTap: () {
                    setState(() {
                      _isStackAlignmentSelected = true;
                    });
                  },
                ),
                SelectableText(
                  'Yellow Block Alignment',
                  isSelected: !_isStackAlignmentSelected,
                  onTap: () {
                    setState(() {
                      _isStackAlignmentSelected = false;
                    });
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SelectableText(
                    'TS',
                    isSelected:
                        isAlignmentSelected(AlignmentDirectional.topStart),
                    onTap: () {
                      onAlignmentSelected(AlignmentDirectional.topStart);
                    },
                  ),
                  SelectableText(
                    'TC',
                    isSelected:
                        isAlignmentSelected(AlignmentDirectional.topCenter),
                    onTap: () {
                      onAlignmentSelected(AlignmentDirectional.topCenter);
                    },
                  ),
                  SelectableText(
                    'TE',
                    isSelected:
                        isAlignmentSelected(AlignmentDirectional.topEnd),
                    onTap: () {
                      onAlignmentSelected(AlignmentDirectional.topEnd);
                    },
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SelectableText(
                  'CS',
                  isSelected:
                      isAlignmentSelected(AlignmentDirectional.centerStart),
                  onTap: () {
                    onAlignmentSelected(AlignmentDirectional.centerStart);
                  },
                ),
                SelectableText(
                  'C',
                  isSelected: isAlignmentSelected(AlignmentDirectional.center),
                  onTap: () {
                    onAlignmentSelected(AlignmentDirectional.center);
                  },
                ),
                SelectableText(
                  'CE',
                  isSelected:
                      isAlignmentSelected(AlignmentDirectional.centerEnd),
                  onTap: () {
                    onAlignmentSelected(AlignmentDirectional.centerEnd);
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SelectableText(
                  'BS',
                  isSelected:
                      isAlignmentSelected(AlignmentDirectional.bottomStart),
                  onTap: () {
                    onAlignmentSelected(AlignmentDirectional.bottomStart);
                  },
                ),
                SelectableText(
                  'BC',
                  isSelected:
                      isAlignmentSelected(AlignmentDirectional.bottomCenter),
                  onTap: () {
                    onAlignmentSelected(AlignmentDirectional.bottomCenter);
                  },
                ),
                SelectableText(
                  'BE',
                  isSelected:
                      isAlignmentSelected(AlignmentDirectional.bottomEnd),
                  onTap: () {
                    onAlignmentSelected(AlignmentDirectional.bottomEnd);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool isAlignmentSelected(AlignmentDirectional alignmentDirectional) {
    return _isStackAlignmentSelected
        ? widget.stackAlignment == alignmentDirectional
        : widget.yellowBlockAlignment == alignmentDirectional;
  }

  void onAlignmentSelected(AlignmentDirectional alignment) {
    if (_isStackAlignmentSelected)
      widget.onStackAlignmentChanged(alignment);
    else
      widget.onYellowBlockAlignmentChanged(alignment);
  }
}

class SelectableText extends StatelessWidget {
  SelectableText(this.text, {this.onTap, this.isSelected});

  final String text;
  final Function onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: GestureDetector(
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade400,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
