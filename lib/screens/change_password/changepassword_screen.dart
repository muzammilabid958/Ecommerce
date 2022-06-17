import 'package:flutter/material.dart';

import 'components/body.dart';

class ChangePasssword extends StatefulWidget {
  static String routeName = "/addressedit";

  @override
  State<ChangePasssword> createState() => _ChangePassswordState();
}

class _ChangePassswordState extends State<ChangePasssword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Body(),
    );
  }
}
