import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const double _defaultLat = 8.85577417427599;
  static const double _defaultLng = 38.85577417427599;
  static const CameraPosition _defaultLocation = CameraPosition(target: LatLng(_defaultLat,_defaultLng),zoom: 15);

  LocationData? currentLocation;

  void getCurrentLocation() {
    Location location = Location();

    location.getLocation().then(
        (location){
          currentLocation = location;
        },
    );
  }

    final Set<Marker> _markers= {};

    void _addMarker() {
      setState((){
        _markers.add(
          Marker(
            markerId: MarkerId('defaultLocation'),
            position: _defaultLocation.target,
            icon: BitmapDescriptor.defaultMarker,
            infoWindow: const InfoWindow(
              title: "PLACE NAME",
              snippet: "RATINGS",
            ),
          ),
        );
      });
    }


  @override
  void initState() {
      getCurrentLocation();
  }
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Google Map'),
          centerTitle: true,
        ), // AppBar
        body: Stack(
          children: <Widget>[
            currentLocation == null ? const Center(child: Text("Loading")) :
            GoogleMap(
                initialCameraPosition:CameraPosition (
                  target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
                  zoom: 13.5,
                ),
            markers: {
              Marker(
                markerId: const MarkerId("currentLocation"),
                position: LatLng(
                  currentLocation!.latitude!, currentLocation!.longitude!),
                )

            }),
            Container(
              padding: const EdgeInsets.only(top: 24, right: 12),
              alignment: Alignment.topRight,
              child: Column(
                children: <Widget>[
                  FloatingActionButton(onPressed: _addMarker,backgroundColor: Colors.deepOrangeAccent,
                  child: const Icon(Icons.add_location,size :36.0),
                  )
                ],
              ), // Column
            ), // Container
          ], // <Widget>[]]
        ),
      ); // Stack
}
