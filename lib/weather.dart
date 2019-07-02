import 'package:flutter/material.dart';
import 'package:dcache/dcache.dart';

import 'openWeather.dart';

Cache c = SimpleCache<int, List<Weather>>(storage: SimpleStorage(size: 1));

class WeatherWidget extends StatefulWidget {
  final String datum;
  WeatherWidget(
    this.datum, {
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WeatherWidgetState(_loadWeather());

  Future<List<Weather>> _loadWeather() {
    WeatherStation weatherStation =
        WeatherStation("4b62a945622a3c28596f5a03a346a0a9");
    int currenthour = DateTime.now().hour;
    List<Weather> oldValue = c.get(currenthour);
    if (oldValue != null) {
      return Future.value(oldValue);
    } else {
      return weatherStation.fiveDayForecast().then((value) {
        c.set(currenthour, value);
        return Future.value(value);
      });
    }
  }
}

class _WeatherWidgetState extends State<WeatherWidget> {
  _WeatherWidgetState(this.weatherFuture);

  final Future<List<Weather>> weatherFuture;

  Weather getWeatherForDate(List<Weather> weathers, String date) =>
      weathers.firstWhere(
        (current) => current.date.toIso8601String() == date,
        orElse: () => null,
      );

  Widget _buildWeatherCard(Weather weather) => Card(
        child: Container(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "${weather.temperature.celsius.toStringAsFixed(1)}°C  ${weather.weatherDescription}",
              ),
              Image.network(
                "http://openweathermap.org/img/wn/${weather.weatherIcon}@2x.png",
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Weather>>(
      future: weatherFuture,
      builder: (BuildContext context, AsyncSnapshot<List<Weather>> list) {
        switch (list.connectionState) {
          case ConnectionState.done:
            if (list.hasError) return Text('Error: ${list.error}');
            Weather weather = getWeatherForDate(list.data, widget.datum);
            return weather == null ? Container() : _buildWeatherCard(weather);
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
