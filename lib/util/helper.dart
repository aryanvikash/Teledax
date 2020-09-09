import 'package:flutter/material.dart';

mysnakBar(_scaffoldKey) {
  final snackbar = SnackBar(
    content: Text("Not Impemented 😝"),
  );

  _scaffoldKey.currentState.showSnackBar(snackbar);
}
