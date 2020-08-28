import 'package:flutter/material.dart';

mysnakBar(_scaffoldKey) {
  final snackbar = SnackBar(
    content: Text("Not Impemented 😝"),
  );
  // Scaffold.of(context).showSnackBar(snackbar);
  _scaffoldKey.currentState.showSnackBar(snackbar);
}
