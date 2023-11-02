import 'package:flutter/material.dart';

class WrappedToggleButton extends StatefulWidget {
  const WrappedToggleButton({
    required this.items,
    required this.selected,
    required this.onSelect,
    super.key
  });
  final List<String> items;
  final int selected;
  final Function onSelect;

  @override
  State<WrappedToggleButton> createState() => _WrappedToggleButton();
}

class _WrappedToggleButton extends State<WrappedToggleButton> {
  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: 4, runSpacing: 8, children: [
      for(var i=0;i<widget.items.length;i++) toggleButton(widget.items[i], i)
    ]);
  }

  Widget toggleButton(String text, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.onSelect(index);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: widget.selected == index ? Theme.of(context).primaryColor : Colors.grey,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(text),
        ),
      ),
    );
  }
}