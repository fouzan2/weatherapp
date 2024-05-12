import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weatherapp/api.dart';
import 'package:weatherapp/screens/searchPage.dart';

class HomePage extends StatefulWidget {
  final String cityName;

  const HomePage({Key? key, required this.cityName}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);

  late Weather? _weather;
  late bool _isLoading = true; // Track whether data is being loaded or not

  @override
  void initState() {
    super.initState();
    _isLoading = true; // Set loading state initially
    _fetchWeatherData(); // Fetch weather data when the widget initializes
  }

  // Method to fetch the current weather data
  Future<void> _fetchWeatherData() async {
    try {
      Weather weather = await _wf.currentWeatherByCityName(widget.cityName);
      setState(() {
        _weather = weather;
        _isLoading = false; // Set loading state to false after data is fetched
      });
    } catch (e) {
      // Handle any errors that occur during data fetching
      print("Error fetching weather data: $e");
      setState(() {
        _isLoading = false; // Set loading state to false even if there's an error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Forecast - ${widget.cityName}'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Navigate to the search page when the search icon is tapped
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()),
              );
            },
          ),
        ],
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    if (_isLoading) {
      // Show a loading indicator if weather data is being fetched
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (_weather == null) {
      // Show an error message if weather data is not available
      return Center(
        child: Text('Failed to fetch weather data.'),
      );
    }
    // If data is available, display weather information as usual
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _locationHeader(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          _dateTimeInfo(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          _weatherIcon(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          _currentTemp(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          _extraInfo(),
        ],
      ),
    );
  }

  Widget _locationHeader() {
    return Text(
      _weather?.areaName ?? "",
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _dateTimeInfo() {
    DateTime now = DateTime.now(); // Use current date and time
    return Column(
      children: [
        Text(
          DateFormat("h:mm a").format(now),
          style: const TextStyle(
            fontSize: 35,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat("EEEE").format(now),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              "  ${DateFormat("d.M.y").format(now)}",
              style: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _weatherIcon() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.10,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png"),
            ),
          ),
        ),
        Text(
          _weather?.weatherDescription ?? "",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Widget _currentTemp() {
    return Text(
      "${_weather?.temperature?.celsius?.toStringAsFixed(0)}° C",
      style: const TextStyle(
        color: Colors.black,
        fontSize: 90,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _extraInfo() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width * 0.80,
      decoration: BoxDecoration(
        color: Colors.tealAccent,
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      padding: const EdgeInsets.all(
        8.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}° C",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              Text(
                "Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}° C",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Wind: ${_weather?.windSpeed?.toStringAsFixed(0)}m/s",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              Text(
                "Humidity: ${_weather?.humidity?.toStringAsFixed(0)}%",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
