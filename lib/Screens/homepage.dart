import 'package:cotrack/Modules/constants.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
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
                style: titleStyle,
              ),
              Divider(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('Country', style: statsStyle),
                  Text(
                    'Confirmed',
                    style: statsStyle,
                  ),
                  Text(
                    'Recovered',
                    style: statsStyle,
                  ),
                  Text(
                    'Deaths',
                    style: statsStyle,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
