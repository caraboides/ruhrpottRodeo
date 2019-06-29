import 'package:flutter/material.dart';
import 'package:ruhrpott_rodeo/openWeather.dart';

class WeatherWidget extends StatelessWidget {
  final Future<List<Weather>> weatherFuture;

  WeatherWidget({
    Key key,
    String date,
  })  : this.weatherFuture = _loadWeather(date),
        super(key: key);

  static Future<List<Weather>> _loadWeather(String date) {
    WeatherStation weatherStation =
        WeatherStation("4b62a945622a3c28596f5a03a346a0a9");
    return weatherStation.fiveDayForecast();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Weather>>(
      future: weatherFuture,
      builder: (BuildContext context, AsyncSnapshot<List<Weather>> list) {
        switch (list.connectionState) {
          case ConnectionState.done:
            if (list.hasError) return Text('Error: ${list.error}');
            Weather weather = list.data.first;
            return Card(
              child: Container(
                height: 50,
                child: Row(children: <Widget>[
                  Text(
                      "${weather.temperature.celsius}°C ${weather.weatherDescription}"),
                  Image.network(
                      "http://openweathermap.org/img/wn/${weather.weatherIcon}@2x.png"),
                ]),
              ),
            );
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
          default:
            return Container();
        }
      },
    );
  }
}
