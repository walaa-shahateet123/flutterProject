  import 'package:flutter/material.dart';
  import 'package:flutter_google_maps/flutter_google_maps.dart';

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {

  Completer<GoogleMapController> _controller = Completer();
// 2
  static final CameraPosition _myLocation =
  CameraPosition(target: LatLng(0, 0),);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1
      body: GoogleMap(
        // 2
        initialCameraPosition: _myLocation,
        // 3
        mapType: MapType.normal,
        // 4
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
}
