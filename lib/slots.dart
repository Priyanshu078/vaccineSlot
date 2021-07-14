import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:vaccine/Data.dart';

class Slots extends StatefulWidget {
  Slots({Key key, @required this.url}) : super(key: key);
  final String url;
  @override
  _SlotsState createState() => _SlotsState();
}

class _SlotsState extends State<Slots> {
  Future<List> getData(String url) async {
    List<Data> slots = [];
    var response;
    print(url);
    try {
      response = await http.get(Uri.parse(url));
    } catch (e) {
      print(e);
    }
    var jsonData = jsonDecode(response.body);
    print(jsonData["sessions"]);
    for (var item in jsonData["sessions"]) {
      Data slot = new Data(
        item["vaccine"],
        item["name"],
        item["district_name"],
        item["state_name"],
        item["fee_type"],
        item["fee"],
        item["date"],
        item["min_age_limit"],
        item["available_capacity_dose1"],
        item["available_capacity_dose2"],
        item["slots"],
      );
      slots.add(slot);
    }
    return slots;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.limeAccent,
      appBar: AppBar(
        title: Text("Slots"),
      ),
      body: FutureBuilder(
          future: getData(widget.url),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 10,
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      snapshot.data[index].vaccine,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(snapshot.data[index].Date),
                                  ]),
                              Text(
                                snapshot.data[index].name,
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(snapshot.data[index].districtName),
                                    Text(snapshot.data[index].state),
                                  ]),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(snapshot.data[index].feeType),
                                    Text(snapshot.data[index].fee),
                                  ]),
                              Text(snapshot.data[index].minAgeLimit.toString()),
                              Text("Dose1 : " +
                                  snapshot.data[index].dose1.toString()),
                              Text("Dose2 : " +
                                  snapshot.data[index].dose2.toString()),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(snapshot.data[index].slots[0]),
                                    Text(snapshot.data[index].slots[1]),
                                  ]),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(snapshot.data[index].slots[2]),
                                    Text(snapshot.data[index].slots[3]),
                                  ]),
                            ],
                          ),
                        ),
                      );
                    });
              }
            }
            return CircularProgressIndicator();
          }),
    );
  }
}
