import 'dart:async';
import 'dart:typed_data';

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart' as places;
import 'package:google_api_headers/google_api_headers.dart';
import 'package:alaket_ios/models/AutoView.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';




const kGoogleApiKey = "AIzaSyBufel5iX9GaTH_P4XVv7A9P1tL88PBbaw";


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  final homeScaffoldKey = GlobalKey<ScaffoldState>();

  double _lat = 0;
  double _lng = 0;
  Completer<GoogleMapController> _controller = Completer();
  Location location = new Location();
  bool _serviceEnabled = false;
  bool _media_loaded = false;
  bool _description_added = false;
  bool _budget_added = false;
  String budget_value = "Бюджет";
  PermissionStatus _permissionGranted;
  CameraPosition _currentPosition;
  String _address = "Где искать исполнителя";
  String how_service_search = "Какую технику ищете?";
  Geolocator _geolocator = Geolocator();
  Set<Marker> _markers = {};
  BitmapDescriptor pinLocationIcon;
  String _mapStyle = "";
  BitmapDescriptor customIcon;
  Uint8List iconMarker = null;
  AnimationController animation;
  Animation<double> _fadeInFadeOut;




  @override
  initState() {
    super.initState();

    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(64, 64)),
        'assets/icons/ic_icon_my_location.png')
        .then((d) {
          customIcon = d;
    });





    _currentPosition = CameraPosition(
      target: LatLng(_lat, _lng),
      zoom: 12,
    );

    animation = AnimationController(vsync: this, duration: Duration(milliseconds: 500),);
    _fadeInFadeOut = Tween<double>(begin: 0.0, end: 1.0).animate(animation);

    animation.addStatusListener((status){
      if(status == AnimationStatus.completed){
        animation.reverse();
      }
      else if(status == AnimationStatus.dismissed){
        animation.forward();
      }
    });
    animation.forward();
    // _markers.add(
    //     Marker(
    //         markerId: MarkerId('current'),
    //         position: LatLng(_lat, _lng),
    //         icon: customIcon
    //     )
    // );
    getBytesFromAsset();
    rootBundle.loadString('assets/json_values/style_map.txt').then((string) {
      _mapStyle = string;
    });
  }


  Future<Uint8List> getBytesFromAsset() async {
    String path = 'assets/icons/ic_icon_my_location.png';
    int width = 48;
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    iconMarker = (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }

  _locateMe() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    await location.getLocation().then((res) async {

      List<Placemark> newPlace = await _geolocator.placemarkFromCoordinates(res.latitude, res.longitude);

      // this is all you need
      Placemark placeMark  = newPlace[0];
      String name = placeMark.name;
      String sbt = placeMark.subThoroughfare;
      String sth = placeMark.thoroughfare;
      String subLocality = placeMark.subLocality;
      String locality = placeMark.locality;
      String administrativeArea = placeMark.administrativeArea;
      String postalCode = placeMark.postalCode;
      String country = placeMark.country;
      String address = "${locality}, ${sth}, ${name}";
      String addressFull = "${sth}, ${name}, ${subLocality}, ${locality}, ${administrativeArea} ${postalCode}, ${country}";

      setAddressToSearch(res.latitude, res.longitude);

      // setState(() {
      //
      //   _lat = res.latitude;
      //   _lng = res.longitude;
      //   _address = address;
      //   setAddressToSearch(res.latitude, res.longitude, address);
      //   // _markers.add(
      //   //     Marker(
      //   //         markerId: MarkerId('my_location'),
      //   //         position: LatLng(_lat, _lng),
      //   //         icon: BitmapDescriptor.fromBytes(iconMarker)
      //   //     )
      //   // );
      //   // if(!_serviceEnabled) {
      //   //   animation.dispose();
      //   // }
      // });
    });
  }




  @override
  dispose() {
    animation.dispose(); // you need this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Widget searchService = Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(8.0),
            topRight: const Radius.circular(8.0),
          )
      ),

      child: Container(
        width: double.infinity,
        height: 48,
        margin: EdgeInsets.only(top:8, left: 8, right: 8),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blueGrey.shade700,
              width: 0.25
            ),
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8))
        ),
        child: Stack(
          children: <Widget> [
            Row(
              children: [
                Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.search, size: 18.0, color: Colors.blueGrey.shade700),
                    ),
                  ),
                ),
                Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          _handlePressButton();
                        },
                        child: Text(
                          how_service_search,
                          style: TextStyle(
                            color: Colors.blueGrey.shade200,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );


    Widget _staticLocationSearch = Container(
      child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.adjust, size: 24.0, color: Colors.blueGrey.shade700),
        ),
      ),
    );


    Widget _animatedLocationSearch = FadeTransition(
      opacity: _fadeInFadeOut,
      child: Container(
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.adjust, size: 24.0, color: Colors.blueGrey.shade700),
          ),
        ),
      ),
    );

    Widget searchAddressContainer = Container(
      width: double.infinity,
      height: 48,
      margin: EdgeInsets.only(top:48, left: 8, right: 8),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      child: Stack(
        children: <Widget> [
          Row(
            children: [
              Container(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.location_on, size: 18.0, color: Colors.blueGrey.shade700),
                  ),
                ),
              ),
              Container(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        _handlePressButton();
                      },
                      child: Text(
                        _address,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                  ),
                ),
              ),
            ],
          ),
            GestureDetector(
              onTap: () {
                _locateMe();
              },
              child: _serviceEnabled?_staticLocationSearch:_animatedLocationSearch,
            ),

        ],
      ),
    );

    Widget time_and_pay = Container(
      width: double.infinity,
      padding: EdgeInsets.only(top:8, left: 8, right: 8),
      height: 56,
      color: Colors.white,
      child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Stack(
                children: <Widget> [
                  Row(
                    children: [
                      Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.timelapse, size: 18.0, color: Colors.blueGrey.shade900),
                          ),
                        ),
                      ),
                      Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Text(
                              "Прямо сейчас",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Stack(
                children: <Widget> [
                  Row(
                    children: [
                      Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.credit_card, size: 18.0, color: Colors.blueGrey.shade900),
                          ),
                        ),
                      ),
                      Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Text(
                              "Безналичный",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            )
          ]
      ),
    );

    Widget budget_descript_media = Container(
      width: double.infinity,
      padding: EdgeInsets.only(top:8, left: 8, right: 8),
      height: 56,
      color: Colors.white,
      child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: new Material(
                child: new InkWell(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.all(8),
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: _budget_added?Colors.deepOrange:Colors.blueGrey.shade900,
                            width: 0.25
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8))
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Icon(
                              Icons.add,
                              size: 18.0,
                              color: Colors.blueGrey.shade700
                          ),
                          Expanded(
                              child: Text(budget_value,
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    color: Colors.blueGrey.shade700,
                                  ),
                                  overflow: TextOverflow.ellipsis
                              )
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: new Material(
                child: new InkWell(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.all(8),
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: _description_added?Colors.deepOrange:Colors.blueGrey.shade900,
                            width: 0.25
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8))
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Icon(
                              Icons.add,
                              size: 18.0,
                              color: Colors.blueGrey.shade700
                          ),
                          Expanded(
                              child: Text('Описание',
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    color: Colors.blueGrey.shade700,
                                  ),
                                  overflow: TextOverflow.ellipsis
                              )
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: new Material(
                child: new InkWell(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.all(8),
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: _media_loaded?Colors.deepOrange:Colors.blueGrey.shade900,
                            width: 0.25
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8))
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Icon(
                              Icons.add,
                              size: 18.0,
                              color: Colors.blueGrey.shade700
                          ),
                          Expanded(
                              child: Text('Медиа',
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    color: Colors.blueGrey.shade700,
                                  ),
                                  overflow: TextOverflow.ellipsis
                              )
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ]
      ),
    );

    Widget mapContainer = Container(
        height: double.infinity,
        width: double.infinity,
        child: GoogleMap(
          initialCameraPosition: _currentPosition,
          markers: _markers,
          onMapCreated: (GoogleMapController controller) {
            GoogleMapController ctrl = controller;
            ctrl.setMapStyle(_mapStyle);
            _controller.complete(ctrl);
            _locateMe();
          },
        )

    );

    Widget buttonAddRequest = Container(
      width: double.infinity,
      padding: EdgeInsets.only(top:8, left: 8, right: 8, bottom: 28),
      height: 84,
      color: Colors.white,
      child: new RaisedButton(
        child: Text("СОЗДАТЬ"),
        onPressed: () {},
        highlightColor: Colors.deepOrange,
        color: Colors.deepOrange,
        textColor: Colors.white,
        padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
        highlightElevation: 8,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        colorBrightness: Brightness.light,
      ),

    );

    Widget optionsContainer = Align(
      alignment: Alignment.bottomCenter,
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          searchService,
          time_and_pay,
          budget_descript_media,
          buttonAddRequest,

        ],
      ),
    );


    return Scaffold(
      key: homeScaffoldKey,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            mapContainer,
            searchAddressContainer,
            optionsContainer,
          ],

        ),
      ),
    );
  }

  void onError(places.PlacesAutocompleteResponse response) {
    String s = response.errorMessage;
    homeScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }

  Future<void> _handlePressButton() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    places.Prediction p = await PlacesAutocomplete.show(
      hint: _address,
      context: context,
      apiKey: kGoogleApiKey,
      onError: onError,
      mode: Mode.fullscreen,
      language: "ru",
      components: [places.Component(places.Component.country, "ru")],
    );

    displayPrediction(p, homeScaffoldKey.currentState);
  }

  Future<Null> displayPrediction(places.Prediction p, ScaffoldState scaffold) async {
    if (p != null) {
      // get detail (lat/lng)
      places.GoogleMapsPlaces _places = places.GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await GoogleApiHeaders().getHeaders(),
      );
      places.PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
      final lat = detail.result.geometry.location.lat;
      final lng = detail.result.geometry.location.lng;

      // scaffold.showSnackBar(
      //   SnackBar(content: Text("${p.description} - $lat/$lng")),
      // );
      setAddressToSearch(lat, lng);
    }
  }

  Future<Null> setAddressToSearch(double latitude, double longitude) async {

    final GoogleMapController controller = await _controller.future;

    final _position = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 17,
    );
    controller.animateCamera(CameraUpdate.newCameraPosition(_position));
    List<Placemark> newPlace = await _geolocator.placemarkFromCoordinates(latitude, longitude);

    // this is all you need
    Placemark placeMark  = newPlace[0];
    String name = placeMark.name;
    String sbt = placeMark.subThoroughfare;
    String sth = placeMark.thoroughfare;
    String subLocality = placeMark.subLocality;
    String locality = placeMark.locality;
    String administrativeArea = placeMark.administrativeArea;
    String postalCode = placeMark.postalCode;
    String country = placeMark.country;

    String address = "${sth}, ${name}";

    String addressFull = "${sth}, ${name}, ${subLocality}, ${locality}, ${administrativeArea} ${postalCode}, ${country}";

    setState(() {
      _lat = latitude;
      _lng = longitude;
      _address = address;
      _markers.add(
          Marker(
              markerId: MarkerId('my_location'),
              position: LatLng(_lat, _lng),
              icon: BitmapDescriptor.fromBytes(iconMarker)
          )
      );
      if(!_serviceEnabled) {
        animation.dispose();
      }

    });


  }

}
