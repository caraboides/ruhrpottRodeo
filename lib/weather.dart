
import 'package:flutter/material.dart';
import 'package:ruhrpott_rodeo/openWeather.dart';


class WeatherWidget extends StatelessWidget {

  final String date;

  const WeatherWidget({
  Key key,
  this.date,
  }) : super(key: key);



  Future<List<Weather>> loadWather()  {
    WeatherStation weatherStation = new WeatherStation("4b62a945622a3c28596f5a03a346a0a9");
    return weatherStation.fiveDayForecast();
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<Weather>>(
      future: loadWather(), // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<List<Weather>> list) {
        switch (list.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Container();
          case ConnectionState.done:
            if (list.hasError)
              return Text('Error: ${list.error}');
            Weather weather = list.data.first;
            return  Row(
                children: <Widget>[Text("${weather.temperature.celsius}°C ${weather.weatherDescription}" ),
                                    Image.network( "http://openweathermap.org/img/wn/${weather.weatherIcon}@2x.png"),]);
        }
        return null; // unreachable
      },
    );
  }


}