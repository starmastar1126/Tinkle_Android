import 'package:flutter/material.dart';
import './registration.dart';
import './addcard.dart';

void main() => runApp(MaterialApp(
      home: Home(),
    ));

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Registration(),
      routes:<String, WidgetBuilder> {
        './StartPage':(BuildContext context)=> new Home(),
        './Payment':(BuildContext context)=> new addcard()
      },
    );}
}
