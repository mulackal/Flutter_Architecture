import 'package:flutter/material.dart';

class TextViewCustomCenter extends StatelessWidget {

 // final bool _answer;
  final double _padding,_font_size;
  final String _text;
  final String _bold;
  final String _color;



  TextViewCustomCenter(this._padding, this._font_size,this._text,this._bold,this._color);

  @override
  Widget build(BuildContext context) {
  return  new Container(
      padding: new EdgeInsets.all(_padding),
      child: new Row(

        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,

        children: <Widget>[
          new Text(_text ,style: new TextStyle(fontSize: _font_size,color: _color =='black' ?
              Colors.black : Colors.white,fontWeight: _bold == 'bold' ?  FontWeight.bold : FontWeight.normal),)
        ],),);
  }
}