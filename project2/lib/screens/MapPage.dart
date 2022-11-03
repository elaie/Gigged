import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

const kGoogleApiKey = 'AIzaSyCqs5UJDkVWs1CcNZx25v8hf3fAIuY5YEg';
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _MapPageState extends State<MapPage> {

  Set<Marker> markersList = {};
  late GoogleMapController googleMapController;
  final Mode _mode = Mode.overlay;
  static const CameraPosition initialCameraPosition = CameraPosition(target: LatLng(37.42796133580664, -122.085749655962), zoom: 14);
  Set<Marker> markers = {};
  //
  // static const double _defaultLat = 8.85577417427599;
  // static const double _defaultLng = 38.85577417427599;
  // static const CameraPosition _defaultLocation =
  //     CameraPosition(target: LatLng(_defaultLat, _defaultLng), zoom: 15);
  //
  // LocationData? currentLocation;
  //
  // void getCurrentLocation() {
  //   Location location = Location();
  //   location.getLocation().then(
  //     (location) {
  //       currentLocation = location;
  //     },
  //   );
  // }
  //
  // final Set<Marker> _markers = {};
  //
  // void _addMarker() {
  //   setState(() {
  //     _markers.add(
  //       Marker(
  //         markerId: MarkerId('defaultLocation'),
  //         position: _defaultLocation.target,
  //         icon: BitmapDescriptor.defaultMarker,
  //         infoWindow: const InfoWindow(
  //           title: "PLACE NAME",
  //           snippet: "RATINGS",
  //         ),
  //       ),
  //     );
  //   });
  // }
  //
  @override
  void initState() {
   // getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,
      appBar: AppBar(
        title: const Text("Google Search Places"),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: initialCameraPosition,
            markers: markersList,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              googleMapController = controller;
            },
          ),
          ElevatedButton(onPressed: _handlePressButton, child: const Text("Search Places")),

        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Position position = await _determinePosition();

          googleMapController
              .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 14)));


          //markersList.clear();

          markersList.add(Marker(markerId: const MarkerId('currentLocation'),position: LatLng(position.latitude, position.longitude)));

          setState(() {});

        },
        label: const Text("Current Location"),
        icon: const Icon(Icons.location_history),
      ),
    );
  }

  Future<void> _handlePressButton() async {
    Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: kGoogleApiKey,
        onError: onError,
        mode: _mode,
        language: 'en',
        strictbounds: false,
        types: [""],
        decoration: InputDecoration(
            hintText: 'Search',
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.white))),
        components: [Component(Component.country,"npl")]);


    displayPrediction(p!,homeScaffoldKey.currentState);
  }

  void onError(PlacesAutocompleteResponse response){

    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   elevation: 0,
    //   behavior: SnackBarBehavior.floating,
    //   backgroundColor: Colors.transparent,
    //   content: AwesomeSnackbarContent(
    //     title: 'Message',
    //     message: response.errorMessage!,
    //     contentType: ContentType.failure,
    //   ),
    // ));

    // homeScaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(response.errorMessage!)));
  }

  Future<void> displayPrediction(Prediction p, ScaffoldState? currentState) async {

    GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders()
    );

    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);

    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;

    markersList.clear();
    markersList.add(Marker(markerId: const MarkerId("0"),position: LatLng(lat, lng),infoWindow: InfoWindow(title: detail.result.name)));

    setState(() {});

    googleMapController.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0));

  }


  // Widget build(BuildContext context) => Scaffold(
  //   appBar: AppBar(
  //     title: const Text("User current location"),
  //     centerTitle: true,
  //   ),
  //   body: GoogleMap(
  //     initialCameraPosition: initialCameraPosition,
  //     markers: markers,
  //     zoomControlsEnabled: false,
  //     mapType: MapType.normal,
  //     onMapCreated: (GoogleMapController controller) {
  //       googleMapController = controller;
  //     },
  //   ),
  //
  //   floatingActionButton: FloatingActionButton.extended(
  //     onPressed: () async {
  //       Position position = await _determinePosition();
  //
  //       googleMapController
  //           .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 14)));
  //
  //
  //       markers.clear();
  //
  //       markers.add(Marker(markerId: const MarkerId('currentLocation'),position: LatLng(position.latitude, position.longitude)));
  //
  //       setState(() {});
  //
  //     },
  //     label: const Text("Current Location"),
  //     icon: const Icon(Icons.location_history),
  //   ),
  //       // appBar: AppBar(
  //       //   title: const Text('Google Map'),
  //       //   centerTitle: true,
  //       // ), // AppBar
  //       // body: Stack(
  //       //   children: <Widget>[
  //       //     currentLocation == null
  //       //         ? const Center(child: Text("Loading"))
  //       //         : GoogleMap(
  //       //             initialCameraPosition: CameraPosition(
  //       //               target: LatLng(currentLocation!.latitude!,
  //       //                   currentLocation!.longitude!),
  //       //               zoom: 13.5,
  //       //             ),
  //       //             markers: {
  //       //                 Marker(
  //       //                   markerId: const MarkerId("currentLocation"),
  //       //                   position: LatLng(currentLocation!.latitude!,
  //       //                       currentLocation!.longitude!),
  //       //                 )
  //       //               }),
  //       //     Container(
  //       //       padding: const EdgeInsets.only(top: 24, right: 12),
  //       //       alignment: Alignment.topRight,
  //       //       child: Column(
  //       //         children: <Widget>[
  //       //           FloatingActionButton(
  //       //             onPressed: _addMarker,
  //       //             backgroundColor: Colors.deepOrangeAccent,
  //       //             child: const Icon(Icons.add_location, size: 36.0),
  //       //           )
  //       //         ],
  //       //       ), // Column
  //       //     ),
  //       //   ],
  //       //
  //       // ),
  //     ); // Sta
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }// ck
}
