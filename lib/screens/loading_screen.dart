import 'package:flutter/material.dart';
import '../services/location.dart';
import '../services/networking.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


const apiKey = '9eaa1177ef441f4d51a8a8236a191344';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('initState Called');
    getLocationData();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print('deactivate Called');
  }

  void getLocationData() async {
    LocationService location = LocationService(); // ../services/location.dart
    await location.getCurrentPosition();

    NetworkHelper networkHelper = NetworkHelper(url: 'http://api.openweathermap.'
        'org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}'
        '&appid=$apiKey&units=metric');

    var decodeData = await networkHelper.getData();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(locationWeather: decodeData,);
    }));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SpinKitDoubleBounce(
            color: Colors.white,
            size: 100.0,
          ),
        ),
      ),
    );
  }
}
