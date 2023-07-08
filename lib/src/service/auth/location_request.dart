import 'package:geolocator/geolocator.dart';

class LocationRequest {
  Future<void> requestLocationPermission() async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }
  }
}
