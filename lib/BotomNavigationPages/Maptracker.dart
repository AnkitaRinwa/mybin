import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_mapbox_navigation/library.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:mybin/loginauth/home.dart';



class Maptracker extends StatefulWidget {
  @override
  _MaptrackerState createState() => _MaptrackerState();
}

class _MaptrackerState extends State<Maptracker> {

  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  late GoogleMapController _controllers;
  Location _location = Location();
  late GoogleMapController mapController; //contrller for Google map
  final Set<Marker> markers = new Set(); //markers for google map
  static const LatLng showLocation = const LatLng(27.7089427, 85.3086209);
  //GoogleMapController? mapController; //contrller for Google map
  PolylinePoints polylinePoints = PolylinePoints();

  String googleAPiKey = "AIzaSyDIGK5c6ewg-me_OhU7VQ23Zm2XLuC1X4k";
  LatLng startLocation = LatLng(28.07491577957711, 74.62003082601488);
  LatLng endLocation = LatLng(28.072886571988228, 74.6236951163583);
  double distance = 0.0;

  Map<PolylineId, Polyline> polylines = {};

  void _onMapCreated(GoogleMapController _cntlr)
  {

    _controllers = _cntlr;
    _location.onLocationChanged.listen((l) {
      _controllers.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude!, l.longitude!),zoom: 15),
        ),
      );
    });
  }
  Set<Marker> getmarkers() { //markers to place on map
    setState(() {
      markers.add(Marker( //add first marker
        markerId: MarkerId(showLocation.toString()),
        position: LatLng(28.0732651, 74.6245115), //position of marker
        infoWindow: InfoWindow( //popup info
          title: 'Gadi 1 ',
          //snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      markers.add(Marker( //add second marker
        markerId: MarkerId(showLocation.toString()),
        position: LatLng(28.0780096, 74.6191174), //position of marker
        infoWindow: InfoWindow( //popup info
          title: 'Gadi 2 ',
         // snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      markers.add(Marker( //add third marker
        markerId: MarkerId(showLocation.toString()),
        position: LatLng(28.0748823, 74.6201413), //position of marker
        infoWindow: InfoWindow( //popup info
          title: 'Gadi 3',
          //snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      //add more markers here
    });
    return markers;
  }



  String _platformVersion = 'Unknown';
  String _instruction = "";
  final _origin = WayPoint(
      name: "Way Point 1",
      latitude: 28.0732651,
      longitude: 74.6245115);
  final _stop1 = WayPoint(
      name: "Way Point 2",
      latitude: 28.0780096,
      longitude: 74.6191174);
  final _stop2 = WayPoint(
      name: "Way Point 3",
      latitude: 28.0748823,
      longitude:  74.6201413,);
  final _stop3 = WayPoint(
      name: "Way Point 4",
      latitude: 28.5937,
      longitude: 74.6201413);
  final _stop4 = WayPoint(
      name: "Way Point 5",
      latitude: 28.0748823,
      longitude: 74.6201413);
  final _farAway = WayPoint(
      name: "Far Far Away", latitude: 36.1175275, longitude: -115.1839524);

  MapBoxNavigation _directions = MapBoxNavigation();
  MapBoxOptions _options = MapBoxOptions();

  bool _arrived = false;
  bool _isMultipleStop = false;
  double _distanceRemaining=0, _durationRemaining=0;
  MapBoxNavigationViewController _controller = MapBoxNavigationViewController(0, null);
  bool _routeBuilt = false;
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();
    print("Yes");
    initialize();

   /* _isMultipleStop = true;
    var wayPoints = <WayPoint>[];
    wayPoints.add(_origin);
    wayPoints.add(_stop1);
    wayPoints.add(_stop2);
    wayPoints.add(_stop3);
    wayPoints.add(_stop4);
    wayPoints.add(_origin);

    await _directions.startNavigation(
        wayPoints: wayPoints,
        options: MapBoxOptions(
            mode: MapBoxNavigationMode.driving,
            simulateRoute: false,
            language: "en",
            allowsUTurnAtWayPoints: true,
            units: VoiceUnits.metric));*/
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initialize() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    _directions = MapBoxNavigation(onRouteEvent: _onEmbeddedRouteEvent);
    print("Yes2");
    _options = MapBoxOptions(
      //initialLatitude: 36.1175275,
      //initialLongitude: -115.1839524,
        zoom: 50.0,
        tilt: 0.0,
        bearing: 0.0,
        enableRefresh: false,
        alternatives: true,
        voiceInstructionsEnabled: true,
        bannerInstructionsEnabled: true,
        allowsUTurnAtWayPoints: true,
        mode: MapBoxNavigationMode.drivingWithTraffic,
        units: VoiceUnits.imperial,
        simulateRoute: false,
        animateBuildRoute: true,
        longPressDestinationEnabled: true,
        language: "en");

    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await _directions.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
        body: Center(
          child: Column(children: <Widget>[
            SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    //Text('Running on: $_platformVersion\n'),
                   /* Container(
                      color: Colors.grey,
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: (Text(
                          "Full Screen Navigation",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                      ),
                    ),*/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RaisedButton(
                          child: Text(lang=="En"?"Start Navigation for your gadi":"अपनी गाडी के लिए नेविगेशन प्रारंभ करें"),
                          onPressed: () async {
                            initialize();
                            var wayPoints = <WayPoint>[];
                            wayPoints.add(_origin);
                            wayPoints.add(_stop1);

                            await _directions.startNavigation(
                                wayPoints: wayPoints,
                                options: MapBoxOptions(
                                    mode:
                                    MapBoxNavigationMode.drivingWithTraffic,
                                    simulateRoute: false,
                                    language: "en",
                                    units: VoiceUnits.metric));
                          },
                        ),
                        /*SizedBox(
                          width: 10,
                        ),
                        RaisedButton(
                          child: Text("Start Multi Stop"),
                          onPressed: () async {
                            _isMultipleStop = true;
                            var wayPoints = <WayPoint>[];
                            wayPoints.add(_origin);
                            wayPoints.add(_stop1);
                            wayPoints.add(_stop2);
                            wayPoints.add(_stop3);
                            wayPoints.add(_stop4);
                            wayPoints.add(_origin);

                            await _directions.startNavigation(
                                wayPoints: wayPoints,
                                options: MapBoxOptions(
                                    mode: MapBoxNavigationMode.driving,
                                    simulateRoute: true,
                                    language: "en",
                                    allowsUTurnAtWayPoints: true,
                                    units: VoiceUnits.metric));
                          },
                        )*/
                      ],
                    ),
                   /* Container(
                      color: Colors.grey,
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: (Text(
                          "Embedded Navigation",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                      ),
                    ),*/

                   /* Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RaisedButton(
                          child: Text(_routeBuilt && !_isNavigating
                              ? "Clear Route"
                              : "Build Route"),
                          onPressed: _isNavigating
                              ? null
                              : () {
                            if (_routeBuilt) {
                              _controller.clearRoute();
                            } else {
                              var wayPoints = <WayPoint>[];
                              wayPoints.add(_origin);
                              wayPoints.add(_stop1);
                              wayPoints.add(_stop2);
                              wayPoints.add(_stop3);
                              wayPoints.add(_stop4);
                              wayPoints.add(_origin);
                              _isMultipleStop = wayPoints.length > 2;
                              _controller.buildRoute(
                                  wayPoints: wayPoints);
                            }
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        RaisedButton(
                          child: Text("Start "),
                          onPressed: _routeBuilt && !_isNavigating
                              ? () {
                            _controller.startNavigation();
                          }
                              : null,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        RaisedButton(
                          child: Text("Cancel "),
                          onPressed: _isNavigating
                              ? () {
                            _controller.finishNavigation();
                          }
                              : null,
                        )
                      ],
                    ),*/
                    Divider(),
              /*Expanded(
                  flex: 1,
                  child:*/
                  Container(
                      //height: MediaQuery.of(context).size.height/(),
                      //width: MediaQuery.of(context).size.width/2,
                    height: 600,
                      width: 500,
                      child:
                          GoogleMap(
                            zoomControlsEnabled: true,
                            initialCameraPosition: CameraPosition(target: _initialcameraposition),
                            mapType: MapType.normal,
                            onMapCreated: _onMapCreated,
                            myLocationEnabled: true,
                            markers: getmarkers(), //markers to show on map
                            polylines: Set<Polyline>.of(polylines.values),
                          ),

                   // ),
                  ),
                  /*  Center(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Long-Press Embedded Map to Set Destination",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.grey,
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: (Text(
                          _instruction == null || _instruction.isEmpty
                              ? "Banner Instruction Here"
                              : _instruction,
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 20.0, right: 20, top: 20, bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text("Duration Remaining: "),
                              Text(_durationRemaining != null
                                  ? "${(_durationRemaining / 60).toStringAsFixed(0)} minutes"
                                  : "---")
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text("Distance Remaining: "),
                              Text(_distanceRemaining != null
                                  ? "${(_distanceRemaining * 0.000621371).toStringAsFixed(1)} miles"
                                  : "---")
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider()
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.grey,
                child: MapBoxNavigationView(
                    options: _options,
                    onRouteEvent: _onEmbeddedRouteEvent,
                    onCreated:
                        (MapBoxNavigationViewController controller) async {
                      _controller = controller;
                      controller.initialize();
                    }),
              ),
            )*/
          ]),
        ),
    ])  ));
  }

  Future<void> _onEmbeddedRouteEvent(e) async {
    _distanceRemaining = await _directions.distanceRemaining;
    _durationRemaining = await _directions.durationRemaining;

    switch (e.eventType) {
      case MapBoxEvent.progress_change:
        var progressEvent = e.data as RouteProgressEvent;
        _arrived = progressEvent.arrived!;
        if (progressEvent.currentStepInstruction != null)
          _instruction = progressEvent.currentStepInstruction!;
        break;
      case MapBoxEvent.route_building:
      case MapBoxEvent.route_built:
        setState(() {
          _routeBuilt = true;
        });
        break;
      case MapBoxEvent.route_build_failed:
        setState(() {
          _routeBuilt = false;
        });
        break;
      case MapBoxEvent.navigation_running:
        setState(() {
          _isNavigating = true;
        });
        break;
      case MapBoxEvent.on_arrival:
        _arrived = true;
        if (!_isMultipleStop) {
          await Future.delayed(Duration(seconds: 3));
          await _controller.finishNavigation();
        } else {}
        break;
      case MapBoxEvent.navigation_finished:
      case MapBoxEvent.navigation_cancelled:
        setState(() {
          _routeBuilt = false;
          _isNavigating = false;
        });
        break;
      default:
        break;
    }
    setState(() {});
  }
}