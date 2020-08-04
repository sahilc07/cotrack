import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cotrack/Modules/checkConnectivity.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    CheckConnectivity.isConnected().then((isConnected) {
      if (!isConnected) {
        CheckConnectivity.showInternetDialog(context);
      }
    });
  }

  Future<List<WorldDatas>> _getWorldData() async {
    http.Response response = await http.get(
        'https://disease.sh/v3/covid-19/countries?yesterday=true&sort=cases&allowNull=tr');
    var data = json.decode(response.body);

    List<WorldDatas> worldData = [];

    for (var i in data) {
      WorldDatas worldDatas = WorldDatas(
          country: i["country"],
          cases: i["cases"],
          deaths: i["deaths"],
          recovered: i["recovered"]);

      worldData.add(worldDatas);
    }
    print(worldData.length);
    return worldData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent[700],
        title: Text(
          "World Covid 19 Cases ",
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        child: FutureBuilder(
          future: _getWorldData(),
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
                      snapshot.data[index].country,
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

class WorldDatas {
  final String country;
  final int cases;
  final int deaths;
  final int recovered;
  WorldDatas({
    this.country,
    this.cases,
    this.deaths,
    this.recovered,
  });
}
