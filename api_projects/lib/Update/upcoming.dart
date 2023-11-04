import 'dart:convert';
import 'package:api_projects/MyData/Mydata.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Upcoming extends StatefulWidget {
  const Upcoming({super.key});

  @override
  State<Upcoming> createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {
  @override
  final url =
      'https://api.cricapi.com/v1/cricScore?apikey=9b3a9f11-71e3-48dc-9889-713a1ff726d4';
  final List<Datum> datum = [];

  @override
  Future<void> Find() async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> FirstBody = json.decode(response.body)['data'];
      // List<Datum> datum = [];
      setState(() {
        for (var i in FirstBody) {
          // print(i);
          Datum data = Datum.fromJson(i);
          if (data.ms.toString() == 'Ms.FIXTURE') {
            print(data.ms.toString());
            datum.add(data);
          }
        }
      });
    } else {
      print("Data not found");
    }
  }

  void initState() {
    // TODO: implement initState
    Find();

    super.initState();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: (datum.isNotEmpty)
              ? ListView.builder(
                  itemCount: datum.length,
                  itemBuilder: ((context, index) => Padding(
                        padding: EdgeInsets.all(20),
                        child: Container(
                          height: 100,
                          width: 200,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(22),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white38,
                                  offset: Offset(2, 6),
                                  blurRadius: 10.0,
                                  spreadRadius: 5.0,
                                )
                              ]),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 25),
                                      child: Text(
                                        datum[index].t1,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 17),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    Text(
                                      datum[index].t1S,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 17),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 11,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 25),
                                      child: Text(
                                        datum[index].t2,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 17),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    Text(
                                      datum[index].t2S,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 17),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 25),
                                      child: Text(
                                        datum[index]
                                            .dateTimeGmt
                                            .toUtc()
                                            .toLocal()
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )))
              : Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 4,
                  ),
                )),
    );
  }
}
