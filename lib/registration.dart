import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './services.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String _name;
  String _email;
  String _address;
  String _Phone;
  String _passWordTemp;
  String _passWord;

  bool _isLoading;

  var _userManagement = new UserManagement();

  final _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    _isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Call Management"),
        ),
        body: Center(
          child: Container(
              padding: EdgeInsets.all(25.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    //===========Name Input================================================
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                      child: new TextFormField(
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        decoration: new InputDecoration(
                            hintText: 'Full Name',
                            icon: new Icon(
                              Icons.person,
                              color: Colors.grey,
                            )),
                        //validator: (value) =>
                        //   value.isEmpty ? 'Name Can Not Be Empty' : null,
                        onSaved: (value) => _name = value,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                      child: new TextFormField(
                        maxLines: 1,
                        keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        decoration: new InputDecoration(
                            hintText: 'Email',
                            icon: new Icon(
                              Icons.mail,
                              color: Colors.grey,
                            )),
                        validator: (value) =>
                            !value.contains("@") ? 'Invalid Email' : null,
                        onSaved: (value) => _email = value,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                      child: new TextFormField(
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        obscureText: true,
                        decoration: new InputDecoration(
                            hintText: 'Enter Password',
                            icon: new Icon(
                              Icons.lock,
                              color: Colors.grey,
                            )),
                        validator: (value) =>
                            value.length < 8 ? 'Password Too Short' : null,
                        onSaved: (value) => _passWordTemp = value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                      child: new TextFormField(
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        autofocus: false,
                        decoration: new InputDecoration(
                            hintText: 'Retype Password',
                            icon: new Icon(
                              Icons.lock,
                              color: Colors.grey,
                            )),
                        validator: (value) {
                          if (value.length > 8) {
                            return null;
                          } else {
                            return "Password Mismatch";
                          }
                        },
                        onSaved: (value) => _passWord = value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                      child: new TextFormField(
                        maxLines: 1,
                        keyboardType: TextInputType.phone,
                        autofocus: false,
                        decoration: new InputDecoration(
                            hintText: 'Phone Number',
                            icon: new Icon(
                              Icons.phone,
                              color: Colors.grey,
                            )),
                        validator: (value) => value.isEmpty
                            ? 'Phone Number Cannot Be Empty '
                            : null,
                        onSaved: (value) => _Phone = value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                      child: new TextFormField(
                        maxLines: 3,
                        obscureText: false,
                        autofocus: false,
                        decoration: new InputDecoration(
                          hintText: 'Address',
                          icon: new Icon(
                            Icons.home,
                            color: Colors.grey,
                          ),
                        ),
                        validator: (value) =>
                            value.isEmpty ? 'Address Must Not Be Empty' : null,
                        onSaved: (value) => _address = value,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    /*Center(
                      child: Text(
                        "Enter Credit Card Details",
                        style: TextStyle(
                            fontWeight: FontWeight.normal, color: Colors.blue),
                      ),
                    ),*/

                    RaisedButton(
                      onPressed: () {
                        setState(() {
                          UserManagement().setIsLoading(true);
                        });
                        if (UserManagement().validateAndSave(_formKey)) {
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: _email, password: _passWord)
                              .then((signedInUser) {
                            UserManagement().storeNewUser(
                                _name, _email, _Phone, _address, context);
                          });
                          setState(() {
                            UserManagement().setIsLoading(false);
                          });
                        } else {
                          setState(() {
                            UserManagement().setIsLoading(false);
                          });
                        }
                      },
                      color: Colors.blue,
                      child: Text('Register'),
                    ),
                    UserManagement().showCircularProgress(),
                  ],
                ),
              )),
        ));
  }

/*bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  //================this part shows the circular progress bar==============
  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }*/
}
