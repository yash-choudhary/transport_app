import 'package:flutter/material.dart';

Widget txtfield(String name, String _controller, bool autofocus,bool obsc, Key key){
  return Padding(
    padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
    child: TextFormField(
      //key: key,
      decoration: InputDecoration(
          labelText: name,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(10.0),
            ),
          ),
          filled: true,
//          hintStyle: new TextStyle(color: Colors.grey[800]),
//          hintText: "Type in your text",
          fillColor: Colors.white70),
      onSaved: (value)=> _controller=value,
      autofocus: autofocus,
      obscureText: obsc,
    ),
  );
}

Widget maxtxtfield(String name, String _controller,bool autofocus, Key key){
  return Padding(
    padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
    child: TextFormField(
      //key: key,
      decoration: InputDecoration(
          labelText: name,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(10.0),
            ),
          ),
          filled: true,
//          hintStyle: new TextStyle(color: Colors.grey[800]),
//          hintText: "Type in your text",
          fillColor: Colors.white70),
      onSaved: (value)=> _controller=value,
      autofocus: autofocus,
      maxLines: null,
      textAlign: TextAlign.left,
      keyboardType: TextInputType.multiline,
    ),
  );
}