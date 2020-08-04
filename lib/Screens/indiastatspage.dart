import 'package:flutter/material.dart';
import 'package:cotrack/Modules/checkConnectivity.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class IndiaStats extends StatefulWidget {
  @override
  _IndiaStatsState createState() => _IndiaStatsState();
}

class _IndiaStatsState extends State<IndiaStats> {
  @override
  void initState() {
    super.initState();
    CheckConnectivity.isConnected().then((isConnected) {
      if (!isConnected) {
        CheckConnectivity.showInternetDialog(context);
      }
    });
  }

  Future<List<IndiaData>> _getIndiaData() async {
    http.Response response =
        await http.get('https://api.covidindiatracker.com/state_data.json');
    var data = json.decode(response.body);

    List<IndiaData> indiaData = [];

    for (var i in data) {
      IndiaData indiaDatas = IndiaData(
          state: i["state"],
          confirmed: i["confirmed"],
          deaths: i["deaths"],
          recovered: i["recovered"]);

      indiaData.add(indiaDatas);
    }
    print(indiaData.length);
    return indiaData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent[700],
        title: Text(
          "India Covid 19 Cases ",
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        child: FutureBuilder(
          future: _getIndiaData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.lightBlueAccent[700],
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                      snapshot.data[index].state,
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class IndiaData {
  final String state;
  final int confirmed;
  final int deaths;
  final int recovered;
  IndiaData({
    this.state,
    this.confirmed,
    this.deaths,
    this.recovered,
  });
}
