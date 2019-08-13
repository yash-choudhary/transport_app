import 'package:flutter/material.dart';

Widget txtfield(String name, TextEditingController _controller, bool autofocus){
  return Padding(
    padding: const EdgeInsets.all(30.0),
    child: TextField(
      controller: _controller,
      autofocus: autofocus,
      decoration: InputDecoration(
          labelText: name
      ),
    ),
  );
}

Widget maxtxtfield(String name, TextEditingController _controller,bool autofocus){
  return Padding(
    padding: const EdgeInsets.all(30.0),
    child: TextField(
      controller: _controller,
      autofocus: autofocus,
      maxLength: null,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
          labelText: name
      ),
    ),
  );
}