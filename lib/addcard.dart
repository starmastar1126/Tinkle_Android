import 'package:flutter/material.dart';
import './services.dart';

class addcard extends StatefulWidget {
  @override
  _addcardState createState() => _addcardState();
}

class _addcardState extends State<addcard> {
  String _cardHolder;
  String _cardNumber;
  String _securityNumber;
  String _expiryDate;

  final _formKey1 = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Add Payment Method"),
        ),
        body: Container(
          padding: EdgeInsets.all(25.0),
          child: Form(
              key: _formKey1,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: ListTile(
                      title: Center(
                          child: Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Text(
                          "Name On Card",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                      subtitle: Container(
                        padding: EdgeInsets.all(5.0),
                        height: 50.0,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white),
                        child: TextFormField(
                          controller: null,
                          validator: (value) =>
                              value.isEmpty ? "Invalid CardHolder" : null,
                          onSaved: (value) => _cardHolder = value,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Enter Name On Card',
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(left: 15.0, top: 15.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: ListTile(
                      title: Center(
                          child: Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          "Add Card Number",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                      subtitle: Container(
                        padding: EdgeInsets.all(5.0),
                        height: 50.0,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white),
                        child: TextFormField(
                            controller: null,
                            validator: (value) =>
                                value.isEmpty ? "Invalid Card Number" : null,
                            onSaved: (value) => _cardNumber = value,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: '  xx-xxxx xxxx xxxx xxxx',
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.only(left: 15.0, top: 15.0),
                                suffixIcon: Image.asset(
                                  "assets/icons8-credit-card-48 (1).png",
                                  scale: 0.9,
                                ))),
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: ListTile(
                        subtitle: TextFormField(
                            controller: null,
                            validator: (value) =>
                                value.isEmpty ? "Invalid Input" : null,
                            onSaved: (value) => _expiryDate = value,
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              hintText: 'MM/YY',
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.only(left: 15.0, top: 15.0),
                            )),
                        title: Text("Expires",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold)),
                      )),
                      Expanded(
                          child: ListTile(
                        subtitle: TextFormField(
                            controller: null,
                            validator: (value) =>
                                value.length != 3 ? "Invalid Input" : null,
                            onSaved: (value) => _securityNumber = value,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                hintText: 'CVV',
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.only(left: 15.0, top: 15.0),
                                suffixIcon: Image.asset(
                                    'assets/icons8-card-verification-value-48.png'))),
                        title: Text("Security Code",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold)),
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  RaisedButton(
                    onPressed: () {
                      setState(() {
                        UserManagement().setIsLoading(true);
                      });
                      if (UserManagement().validateAndSave(_formKey1)) {
                        setState(() {
                          UserManagement().setIsLoading(false);
                        });
                      }
                    },
                    child: Text("Add Credit Card "),
                    color: Colors.blue,
                  ),
                  UserManagement().showCircularProgress()
                ],
              )),
        ));
  }
}
