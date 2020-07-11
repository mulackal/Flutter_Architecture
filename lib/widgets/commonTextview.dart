import 'package:flutter/material.dart';

class TextViewCustom extends StatelessWidget {

 // final bool _answer;
  final double _padding,_font_size;
  final String _text;
  final String _bold;



  TextViewCustom(this._padding, this._font_size,this._text,this._bold);

  @override
  Widget build(BuildContext context) {
  return  new Container(
      padding: new EdgeInsets.all(_padding),

      child: new Row(

        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,

        children: <Widget>[
          new Text(_text ,
            textAlign: TextAlign.justify,
            style: new TextStyle(fontSize: _font_size,color: Colors.grey,fontWeight: _bold == 'bold' ?  FontWeight.bold : FontWeight.normal),)
        ],),);
  }
}