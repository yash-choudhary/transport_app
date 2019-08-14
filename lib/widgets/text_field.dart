import 'package:flutter/material.dart';

Widget txtfield(String name, TextEditingController _controller, bool autofocus,bool obsc){
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: TextField(
      controller: _controller,
      autofocus: autofocus,
      obscureText: obsc,
      decoration: InputDecoration(
          labelText: name
      ),
    ),
  );
}

Widget maxtxtfield(String name, TextEditingController _controller,bool autofocus){
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: TextField(
      controller: _controller,
      autofocus: autofocus,
      maxLines: null,
      textAlign: TextAlign.left,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
          labelText: name
      ),
    ),
  );
}