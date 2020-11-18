import 'package:flutter/material.dart';

Future buildErrorDialog(BuildContext context, _message) {
  return showDialog(
    builder: (context) {
      return AlertDialog(
        title: Text('Error Message'),
        content: Text(_message),
        actions: <Widget>[
          FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              })
        ],
      );
    },
    context: context,
  );
}

Future buildAlertDialog(BuildContext context, ontap) {
  return showDialog(
    builder: (context) {
      return AlertDialog(
        title: Text('Want To Log Out?'),
        actions: <Widget>[
          FlatButton(child: Text('Yes'), onPressed: ontap),
          FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              })
        ],
      );
    },
    context: context,
  );
}
