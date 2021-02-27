import 'package:flutter/material.dart';

class SelectableButton extends StatelessWidget {
  SelectableButton({this.onTap, this.text, this.isSelected});

  final Function onTap;
  final String text;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}

class Category extends StatelessWidget {
  Category({this.title, this.options});

  final String title;
  final List<Widget> options;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.blue,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(title),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: options,
          )
        ],
      ),
    );
  }
}
