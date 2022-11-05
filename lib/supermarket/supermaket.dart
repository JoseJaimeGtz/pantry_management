import 'dart:convert';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:pantry_management/home/menu.dart';
import 'package:pantry_management/supermarket/nearby_places_response.dart';

class SuperMarkets extends StatefulWidget {
  const SuperMarkets({super.key});

  @override
  State<SuperMarkets> createState() => _SuperMarketsState();
}

class _SuperMarketsState extends State<SuperMarkets> {
  late GoogleMapController googleMapController;

  //Cambiar a que el mapa muestre la ubicación del usuario al mostrarse
  static const CameraPosition initialPosition =
      CameraPosition(target: LatLng(20.605765, -103.476892), zoom: 14.0);

  Set<Marker> markers = {};

  //NearbyPlacesResponse
  NearbyPlacesResponse nearbyPlaces = NearbyPlacesResponse();

  //Custom Info Window
  //CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nearby Supermarket's Map"),
        centerTitle: true,
      ),
      body: Stack(children: <Widget>[
        GoogleMap(
          initialCameraPosition: initialPosition,
          mapType: MapType.normal,
          markers: markers,
          zoomControlsEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            googleMapController = controller;
          },
        ),
        /*CustomInfoWindow(
          controller: _customInfoWindowController,
          height: 200,
          width: 300,
          offset: 35,
        ),*/
      ]),
      drawer: Container(width: 250, child: userMenu(context)),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FloatingActionButton.extended(
               heroTag: "btn1",
                onPressed: () async {
                  _getNearbyPlaces();
                },
                label: Text("Search Nearby"),
                icon: Icon(Icons.search_sharp)),
            FloatingActionButton.extended(
               heroTag: "btn2",
                onPressed: showUserLocation,
                label: Text("My location"),
                icon: Icon(Icons.location_history))
          ],
        ),
      ),
    );
  }

  void showUserLocation() async {
    Position position = await _determinePosition();

    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(position.latitude, position.longitude), zoom: 14)));

    String imgurl = "https://cdn-icons-png.flaticon.com/128/5693/5693831.png";
    Uint8List bytes = (await NetworkAssetBundle(Uri.parse(imgurl)).load(imgurl))
        .buffer
        .asUint8List();

    //markers.clear();

    markers.add(Marker(
        markerId: const MarkerId('currentLocation'),
        position: LatLng(position.latitude, position.longitude),
        icon: BitmapDescriptor.fromBytes(bytes)));

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
    print('position $position');
    return position;
  }

  Future<String> _getKey() async {
    await dotenv.load(fileName: ".env");
    var key = dotenv.env['GOOGLE_API_KEY'];
    return key!;
  }

  void _getNearbyPlaces() async {
    String api_key = await _getKey();
    Position position = await _determinePosition();
    String radius = "10000";

    print(api_key);

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

    print(url);

    var response = await http.post(url);

    //print(data);
    nearbyPlaces = NearbyPlacesResponse.fromJson(jsonDecode(response.body));

    //print(nearbyPlaces.results);

    String imgurl = "https://cdn-icons-png.flaticon.com/128/4931/4931334.png";
    Uint8List bytes = (await NetworkAssetBundle(Uri.parse(imgurl)).load(imgurl))
        .buffer
        .asUint8List();

    for (int i = 0; i < nearbyPlaces.results!.length; i++) {
      print(nearbyPlaces.results![i].name);
      double lat = nearbyPlaces.results![i].geometry!.location!.lat!;
      double lng = nearbyPlaces.results![i].geometry!.location!.lng!;
      String name = nearbyPlaces.results![i].name!;
      dynamic rating = nearbyPlaces.results![i].rating;

      if (rating == null) rating = "No";
      //print(nearbyPlaces.results![i].rating.runtimeType);
      String id = "supermarket${i}";

      markers.add(
        Marker(
          markerId: MarkerId(id),
          position: LatLng(lat, lng),
          icon: BitmapDescriptor.fromBytes(bytes),
          infoWindow: InfoWindow(title: name, snippet: '${rating} Star Rating'),
          onTap: () {
            //cambiar variable aqui
            //setState(() {});
            //funcion del widget
            print("hola");
            LatLng latLng = LatLng(lat, lng);
            print(latLng);

            /* _customInfoWindowController.addInfoWindow!(
                Container(
                ),
                latLng);*/
          },
        ),
      );
    }

    setState(() {});
  }
}
