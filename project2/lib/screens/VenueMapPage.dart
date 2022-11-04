import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:project2/userClass.dart';

//import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../getData.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import '../storage_services.dart';

class VenueMapPage extends StatefulWidget {
  const VenueMapPage({Key? key}) : super(key: key);

  @override
  State<VenueMapPage> createState() => _VenuMapPageState();
}

const kGoogleApiKey = 'AIzaSyCqs5UJDkVWs1CcNZx25v8hf3fAIuY5YEg';
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _VenuMapPageState extends State<VenueMapPage> {
  //list of markers
  List<Object> _maList = [];
  final Set<Marker> markers = new Set();
  List<Object> _ListM = [];

  void addMarkerMap() {
    markers.add(Marker(
      //add first marker
      markerId: MarkerId("showLocation.toString()"),
      position: LatLng(27.7099116, 85.3132343), //position of marker
      infoWindow: InfoWindow(
        //popup info
        title: 'My Custom Title ',
        snippet: 'My Custom Subtitle',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    markers.add(Marker(
      //add second marker
      markerId: MarkerId("showLocation.toString()"),
      position: LatLng(27.7099116, 85.3132343), //position of marker
      infoWindow: InfoWindow(
        //popup info
        title: 'My Custom Title ',
        snippet: 'My Custom Subtitle',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));
  }

  var venueName;
  var venueLat ;
  var venueLong;
  final Storage storage = Storage();
  Set<Marker> markersList = {};
  Set<Marker> markersListall = {};
  double Lat = 0;
  double Long = 0;
  late GoogleMapController googleMapController;
  final Mode _mode = Mode.overlay;
  static const CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962), zoom: 100);

  //Set<Marker> markers = {};

  @override
  void initState() {
    addMarkerMap();
    //getMarkerFromDb();
    activateListner();
    super.initState();
  }

  void activateListner() async {
    Position position = await _determinePosition();
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(position.latitude, position.longitude), zoom: 14)));
    //markersList.clear();
    markers.add(Marker(
        markerId: const MarkerId('currentLocation'),
        position: LatLng(position.latitude, position.longitude),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: const InfoWindow(
          title: "Update Venue Location",
        )));

    setState(() {});
  }

  Set<Marker> getmarkers() {
    setState(() {
      markers.add(const Marker(
        //add first marker
        markerId: MarkerId("1"),
        position: LatLng(37.42796133580664, -122.085749655962),
        //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: 'Marker Title First ',
          snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      markers.add(const Marker(
        //add second marker
        markerId: MarkerId("2"),
        position: LatLng(57.42796133580664, -126.085749655962),
        //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: 'Marker Title Second ',
          snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      markers.add(const Marker(
        //add third marker
        markerId: MarkerId("3"),
        position: LatLng(57.7137735, -85.315626), //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: 'Marker Title Third ',
          snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      //add more markers here
    });

    return markers;
  }

  Set<Marker> getmarkersall() {

      print("VENUELAT==============="+venueLat);
      markers.add(Marker(
        //add first marker
        markerId: MarkerId("1"),
        position: LatLng(venueLat.toDouble(), venueLong.toDouble()),
        //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: 'TEST MARKER',
          snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,
      appBar: AppBar(
        title: const Text("Google Search Places"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Artist').snapshots(),
        builder: (context, snapshots) {
          return (snapshots.connectionState == ConnectionState.waiting)
              ? Center(
            child: CircularProgressIndicator(),
          )
              : ListView.builder(

              itemCount: snapshots.data!.docs.length,
              itemBuilder: (context, index) {
                var data = snapshots.data!.docs[index].data()
                as Map<String, dynamic>;
                print("data printing");
                print(data);
                return Container();
              });
        },
      ),

      // body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      //     future: FirebaseFirestore.instance
      //         .collection('Venue')
      //         .doc()
      //         .get(),
      //     builder: (_, snapshot) {
      //       if (snapshot.connectionState == ConnectionState.waiting) {
      //         return const Center(
      //           child: CircularProgressIndicator(),
      //         );
      //       } else {}
      //       var data = snapshot.data!.data();
      //       venueName = data!['Name'];
      //
      //       venueLat = data['Latitude'];
      //       print("VENUE LAT==================="+venueLat.toString());
      //       venueLong = data['Longitude'];
      //       return Stack(
      //
      //
      //       );
      //
      //     }),


      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final uid = extractData().getUserUID();
          final docUser =
              FirebaseFirestore.instance.collection('Venue').doc(uid);
          docUser.update({});
          Position position = await _determinePosition();
          Lat = position.latitude;
          Long = position.longitude;
          docUser.update({"Latitude": Lat, "Longitude": Long});
          // googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          //     CameraPosition(
          //         target: LatLng(position.latitude, position.longitude),
          //         zoom: 14)));
          // //markersList.clear();
          // markersList.add(Marker(
          //     markerId: const MarkerId('currentLocation'),
          //     position: LatLng(position.latitude, position.longitude),
          //     infoWindow: const InfoWindow(
          //       title: "Update Venue Location",
          //     )
          // ));

          setState(() {});
        },
        label: const Text("Update Venue Location"),
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
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white))),
        components: [Component(Component.country, "npl")]);

    displayPrediction(p!, homeScaffoldKey.currentState);
  }

  void onError(PlacesAutocompleteResponse response) {
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

  Future<void> displayPrediction(
      Prediction p, ScaffoldState? currentState) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders());

    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);

    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;

    markersList.clear();
    markersList.add(Marker(
        markerId: const MarkerId("0"),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: detail.result.name)));

    setState(() {});

    googleMapController
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0));
  }

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
  } //
}
