import 'package:flutter/material.dart';
import 'package:vaccine/slots.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vaccine Slots',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Vaccine Slots'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, @required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controllerDate = new TextEditingController();
  TextEditingController _controllerPincode = new TextEditingController();
  String date = "";
  String pincode = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Find vaccine slots",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _controllerPincode,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: "Enter Pincode",
                labelText: "Pincode",
              ),
            ),
            TextField(
              controller: _controllerDate,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: "Enter date",
                labelText: "Date",
              ),
            ),
            Image.asset(
              'assets/vaccine.png',
              scale: 2,
            ),
            MaterialButton(
              height: 40,
              minWidth: double.infinity,
              child: Text(
                "Find Slots",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              color: Colors.lightBlue,
              onPressed: () {
                String pincode = _controllerPincode.text;
                String date = _controllerDate.text;
                String url =
                    "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode=$pincode&date=$date";
                print("Finding slots");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Slots(
                              url: url,
                            )));
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
