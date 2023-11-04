import 'dart:convert';
import 'package:api_projects/SplashScreen.dart';
import 'package:api_projects/Update/result.dart';
import 'package:api_projects/Update/upcoming.dart';

import 'GetData.dart';
import 'package:api_projects/MyData/Mydata.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

import 'Update/live.dart';

void main() {
  runApp(const Splash1());
}

class API extends StatefulWidget {
  const API({super.key});

  @override
  State<API> createState() => _APIState();
}

class _APIState extends State<API> {
  // TODO: implement initState
 


  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blue,
                title: Text(
                  "MyCricScore",
                  style:
                      GoogleFonts.ramaraja(color: Colors.white, fontSize: 28),
                ),
                bottom: TabBar(
                    indicatorColor: Colors.white,
                    labelColor: Colors.white,
                    indicatorWeight: 4,
                    tabs: [
                      Tab(
                        text: 'Live',
                      ),
                      Tab(
                        text: 'Upcoming',
                      ),
                      Tab(
                        text: 'Result',
                      )
                    ]),
              ),
              body: TabBarView(children: [Live(), Upcoming(), Result()]),
            )));
  }
}
