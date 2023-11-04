import 'dart:convert';
import 'package:api_projects/GetData.dart';
import 'package:api_projects/MyData/Mydata.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Live extends StatefulWidget {
  const Live({super.key});

  @override
  State<Live> createState() => _LiveState();
}

class _LiveState extends State<Live> {
  @override
  final url =
      'https://api.cricapi.com/v1/cricScore?apikey=9b3a9f11-71e3-48dc-9889-713a1ff726d4';
  final List<Datum> datum = [];
  late int now;

  Future<void> Find() async {
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List FirstBody = json.decode(response.body)['data'];

      setState(() {
        for (var i in FirstBody) {
          // print(i);
          Datum data = Datum.fromJson(i);
          print(data.ms.toString());
          if (data.ms.toString() == 'Ms.LIVE') {
            datum.add(data);
          }

          //print(datum.length);
        }
      });
    } else {
      print("Data not found");
    }
  }

  void initState() {
    // TODO: implement initState
    Find();
    now = DateTime.now().hour;

    if (now > 12) {
      now -= 12;
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    print(datum.length);
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
                              borderRadius: BorderRadius.circular(26),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 11,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                    ),
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
                                        (datum[index].status.toString() ==
                                                'Match not started')
                                            ? 'Match to begin soon'
                                            : datum[index].status.toString(),
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
