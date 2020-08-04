import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cotrack/Modules/checkConnectivity.dart';
import 'package:url_launcher/url_launcher.dart';

class Helpline extends StatefulWidget {
  @override
  _HelplineState createState() => _HelplineState();
}

class _HelplineState extends State<Helpline> {
  void launchCaller(var number) async {
    var url = 'tel:${number.toString()}';
    if (await canLaunch(url)) {
      launch(url);
    } else {
      throw 'Could not place call';
    }
  }

  @override
  void initState() {
    super.initState();
    CheckConnectivity.isConnected().then((isConnected) {
      if (!isConnected) {
        CheckConnectivity.showInternetDialog(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent[700],
        title: Text(
          "India Helpline",
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder(
              stream: Firestore.instance
                  .collection('helpline')
                  .orderBy("state")
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                  );

                return Expanded(
                  flex: 1,
                  child: ListView(
                    children: snapshot.data.documents.map(
                      (document) {
                        return Column(
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                document['state'].toString(),
                                softWrap: true,
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              subtitle: InkWell(
                                onTap: () => launchCaller(document['number']),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.phone,
                                        color: Colors.lightBlueAccent[700],
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        document['number'].toString(),
                                        softWrap: true,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.lightBlueAccent[700],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Divider(),
                          ],
                        );
                      },
                    ).toList(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
