import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatefulWidget {
  final List<DropdownMenuItem<T>> items;
  final T value;
  final Function(T) onChanged;
  final String hintText;
  const CustomDropdown({super.key, required this.items, required this.value, required this.onChanged, required this.hintText});

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: Colors.grey),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: widget.value,
          onChanged: (f) => widget.onChanged,
          items: widget.items,
          isExpanded: true,
          hint: Text(widget.hintText),
        ),
      ),
    );
  }
}