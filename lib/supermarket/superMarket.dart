import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pantry_management/home/menu.dart';
import 'package:http/http.dart' as http;
import 'package:pantry_management/supermarket/directions.dart';
import 'package:pantry_management/supermarket/directions_repository.dart';
import 'package:pantry_management/supermarket/nearby_places_response.dart';

void main() => runApp(const SuperMarket());

class SuperMarket extends StatefulWidget {
  const SuperMarket({super.key});

  @override
  State<SuperMarket> createState() => _SuperMarketState();
}

class _SuperMarketState extends State<SuperMarket> {
  late GoogleMapController googleMapController;

  //Cambiar a que el mapa muestre la ubicación del usuario al mostrarse
  static const CameraPosition initialPosition =
      CameraPosition(target: LatLng(20.605765, -103.476892), zoom: 14.0);

  Set<Marker> markers = {};

  //NearbyPlacesResponse
  NearbyPlacesResponse nearbyPlaces = NearbyPlacesResponse();

  Directions _routes = Directions(
    bounds: LatLngBounds(southwest: LatLng(20.6256664,-103.448254), northeast: LatLng(20.6256664,-103.448254)), 
    polylinePoints: PolylinePoints().decodePolyline(""), 
    totalDistance: "0", 
    totalDuration: "0"
    );
  //late Directions _routes;

  //card
  bool show = false;
  int infoId = -1;

  //Routes
  //var _line = Polyline(polylineId: PolylineId('routeLine'));
  var _line = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getLoc(), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              Scaffold(
                appBar: AppBar(
                  title: Text("Nearby Supermarket's Map"),
                  centerTitle: true,
                ),
                body: Stack(children: <Widget>[
                  initializeMap(),
                  Positioned(
                      bottom: 70,
                      left: 10,
                      right: 10,
                      child: Container(
                          child: show ? InfoCard(context) : Text(""))),
                  Positioned(
                      top: 20,
                      left: 12,
                      //right: 10,
                      child: FloatingActionButton(
                          backgroundColor: Colors.white,
                          highlightElevation: 10.0,
                          onPressed: () {
                            showUserLocation();
                          },
                          //share_location_outlined
                          child: Icon(Icons.my_location,
                              size: 30,
                              color: Color.fromARGB(255, 87, 85, 85)))),
                ]),
                drawer: Container(width: 250, child: userMenu(context)),
              )
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              ),
            ];
          } else {
            children = <Widget>[
              SafeArea(
                  child: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Text('Awaiting result...'),
                        SizedBox(height: 15),
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: CircularProgressIndicator(
                            strokeWidth: 5,
                          ),
                        ),
                      ],
                    )),
              )),
            ];
          }
          return Scaffold(
            body: Stack(
              fit: StackFit.expand,
              children: children,
            ),
          );
        },
      ),
    );
  }

  GoogleMap initializeMap() {
    if (markers.length == 0) {
      _getNearbyPlaces();
    }

    return GoogleMap(
      initialCameraPosition: initialPosition,
      mapType: MapType.normal,
      markers: markers,
      zoomControlsEnabled: true,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      scrollGesturesEnabled: true,
      tiltGesturesEnabled: false,
      rotateGesturesEnabled: true,
 
      onMapCreated: (GoogleMapController controller) {
        googleMapController = controller;
      },
      polylines: {
        //if (_routes != null)
        _line = Polyline(
            polylineId: const PolylineId('overview_polyline'),
            color: Colors.blue,
            width: 5,
            points: _routes.polylinePoints
                .map((e) => LatLng(e.latitude, e.longitude))
                .toList(),
          ),
      },
      onTap: (argument) {
        show = false;
        //_line.setMap(null);
        //_line.clear();
        setState(() {});
      },
    );
  }

  Future<String> getLoc() async {
    Position position = await _determinePosition();
    return position.toString();
  }

  Future<void> showUserLocation() async {
    Position position = await _determinePosition();

    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(position.latitude, position.longitude), zoom: 14)));

    setState(() {});
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error("Location services are disabled");
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  Future<String> _getKey() async {
    await dotenv.load(fileName: ".env");
    var key = dotenv.env['GOOGLE_API_KEY'];
    return key!;
  }

  Future<void> _getNearbyPlaces() async {
    String api_key = await _getKey();
    Position position = await _determinePosition();
    String radius = "10000";

    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=' +
            position.latitude.toString() +
            ',' +
            position.longitude.toString() +
            '&radius=' +
            radius +
            '&type=supermarket' +
            '&key=' +
            api_key);

    var response = await http.post(url);

    nearbyPlaces = NearbyPlacesResponse.fromJson(jsonDecode(response.body));

    String imgurl = "https://cdn-icons-png.flaticon.com/128/4931/4931334.png";
    Uint8List bytes = (await NetworkAssetBundle(Uri.parse(imgurl)).load(imgurl))
        .buffer
        .asUint8List();

    for (int i = 0; i < nearbyPlaces.results!.length; i++) {
      double lat = nearbyPlaces.results![i].geometry!.location!.lat!;
      double lng = nearbyPlaces.results![i].geometry!.location!.lng!;
      String name = nearbyPlaces.results![i].name!;
      dynamic rating = nearbyPlaces.results![i].rating;
      String placeId = nearbyPlaces.results![i].placeId!;

      if (rating == null) rating = "No";

      String id = "supermarket${i}";

      markers.add(
        Marker(
          markerId: MarkerId(id),
          position: LatLng(lat, lng),
          icon: BitmapDescriptor.fromBytes(bytes),
          infoWindow: InfoWindow(title: name, snippet: '${rating} Star Rating'),
          onTap: () async {
            show = true;
            infoId = i;

            _routes = await DirectionsRepository()
                .getDirections(placeId, position, api_key);
      
            //setState(() => _info = directions);

            setState(() {});
          },
        ),
      );
    }
    setState(() {});
  }

  InfoCard(BuildContext context) {
    if (infoId == -1) return Card();
    bool openingHours =
        nearbyPlaces.results?[infoId].openingHours?.openNow ?? false;

    return Card(
      color: Color.fromARGB(255, 255, 255, 255),
      elevation: 30,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Color.fromARGB(255, 254, 252, 255)),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: SizedBox(
          width: 350,
          height: 170,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Container(
                  padding: EdgeInsets.only(top: 12, left: 12),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: openingHours
                            ? Text('Open Now!',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.green))
                            : Text('Closed Now',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red)),
                      ),
                      SizedBox(height: 12),
                      Text("Address:",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600)),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text(
                          '${nearbyPlaces.results![infoId].vicinity!}',
                          style: TextStyle(fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                        ),
                      ),
                    ],
                  ),
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
              ),
              VerticalDivider(color: Colors.black, width: 0.2),
              Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.width * 0.6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left:20, top:8, right:30, bottom:2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.time_to_leave,
                                color: Color.fromARGB(255, 74, 14, 102)),
                            Text("${_routes.totalDistance}"),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left:20, top:8, right:30, bottom:2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.timer_outlined,
                                color: Color.fromARGB(255, 74, 14, 102)),
                            Text("${_routes.totalDuration}"),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.directions,
                          size: 50,
                          color: Colors.blueAccent,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text("Show directions"))
                    ],
                  )),
            ],
          )),
    );
  }
}
