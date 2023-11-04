import 'dart:convert';
import 'package:api_projects/MyData/Mydata.dart';
import 'package:http/http.dart' as http;

class GetData {
  final url =
      'https://api.cricapi.com/v1/cricScore?apikey=9b3a9f11-71e3-48dc-9889-713a1ff726d4';
 final List<Datum> datum = [];
  Future result() async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
       List<dynamic> FirstBody = json.decode(response.body)['data'] as List;
List<Datum> datum = [];
      for (var i in FirstBody) {
        Datum data = Datum.fromJson(i);
        datum.add(data);
      }
     
     
    } else {
      print("Data not found");
    }
     return datum;
    
  }
}
