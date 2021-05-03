import 'package:geolocator/geolocator.dart';

class Location {
  double latitude;
  double longitude;

  Future<void> getCurrentLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('Location services are disabled.');
        return;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Permission was denied.');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        print('Permission was denied forever.');
        return;
      }
      Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.low)
          .timeout(Duration(seconds: 5));
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
