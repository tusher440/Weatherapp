import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  var _tem, _hum, _win, _temp, _tempc;

  Future getweatherinfo() async{
    http.Response _respone = await http.get("https://api.openweathermap.org/data/2.5/weather?q=Dhaka&appid=32511dee4a22469574a36f13f8be3c55");

    var _result = jsonDecode(_respone.body);

    setState(() {
      this._tem = _result ["main"] ["temp"];
      _temp = (_tem-273.15);
      _tempc = double.parse(_temp.toStringAsFixed(2));
      this._hum = _result ["main"] ["humidity"];
      this._win = _result ["wind"] ["speed"];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getweatherinfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text("Weather App"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Location Dhaka"),
            SizedBox(height: 20,),
            Row(
              children: [
                Center(child: Text('Temperature: ')),
                Text(_tempc != null ? _tempc.toString()+"\u00B0" : "Loading")
              ],
            ),

            SizedBox(height: 10,),
            Row(
              children: [
                Text('Humidity: '),
                Text(_hum != null ? _hum.toString()+"%" : "Loading")
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Text('Wind: '),
                Text(_win != null ? _win.toString()+"km/h" : "Loading")
              ],
            )
          ],
        ),
      ),
    );
  }
}
