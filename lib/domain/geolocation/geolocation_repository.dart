import 'package:geolocator/geolocator.dart';


class GeolocationRepository {
  
  Future<Position?> getCurrentPosition() async {
    final serviceEnable = await Geolocator.isLocationServiceEnabled();

    if(!serviceEnable) return null;

    final permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied || permission == LocationPermission.unableToDetermine) {
      final res = await GeolocatorPlatform.instance.requestPermission();

      if (res != LocationPermission.denied || res != LocationPermission.unableToDetermine) {
        return await _getUserLocation();
      } else {
        return null;
      }
    }

    return _getUserLocation();
  }

  Future<Position> _getUserLocation() async {
    try {
      final position = await GeolocatorPlatform.instance
          .getCurrentPosition(locationSettings: const LocationSettings(accuracy: LocationAccuracy.high));
      return position;
    } on Object catch (e, stackTrace) {
      Error.throwWithStackTrace(e, stackTrace);
    }
  }
}
