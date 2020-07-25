import 'package:flutter/material.dart';

class HelplinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Cotrack',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
