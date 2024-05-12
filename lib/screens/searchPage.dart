import 'package:flutter/material.dart';
import 'weatherHomePage.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();

    return Scaffold( // Wrap with Scaffold
      appBar: AppBar(
        title: Text('Enter City Name'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: 'Enter city name',
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (text) {
            // Implement city suggestions logic here
          },
          onSubmitted: (text) {
            // Navigate to weather forecast screen with the entered city name
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage(cityName: _controller.text)),
            );
          },
        ),
      ),
    );
  }
}
