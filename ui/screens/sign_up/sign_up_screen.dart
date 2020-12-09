import 'package:flutter/material.dart';
import 'components/body.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent),
        body: Body(),
      ),
    );
  }
}
