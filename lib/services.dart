import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserManagement {
  bool _isLoading = false;

   storeNewUser(userName, userEmail, userPhoneNumber, userAddress, context) {
    DocumentReference input =
        Firestore.instance.collection('/users').document(userEmail);
    Map<String, dynamic> UserDetails = {
      'name': userName,
      'email': userEmail,
      'phoneNumber': userPhoneNumber,
      'address': userAddress,
    };
    try {
      input.setData(UserDetails).then((value) {
        print('user added to database\n');
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed('./Payment');
      }).whenComplete(() {
        print("operation complete\n");
      });
    } catch (e) {
      return false;
      print(e);
    }
  }

  void setIsLoading(bool value) {
    _isLoading = value;
  }

  bool getIsLoading() {
    return _isLoading;
  }

  Widget showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  bool validateAndSave(formKey) {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
