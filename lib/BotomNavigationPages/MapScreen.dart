/*import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class MapScreenWidget extends StatefulWidget {

  MapScreenWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MapState();
}

class _MapState extends State<MapScreenWidget> {
  GlobalKey <_MapState> mapKey = GlobalKey<_MapState>();
  late MapController controller;


  @override
  void initState() {
    super.initState();
    controller = MapController(
      initMapWithUserPosition: true,
    );


  }

  Rout_loc()
  async {
    RoadInfo roadInfo = await controller.drawRoad( GeoPoint(latitude:28.074922745459943, longitude: 74.62228878378716),GeoPoint(latitude: 28.079938173218192, longitude: 74.6182404840264));
    print("${roadInfo.distance}km");
    print("${roadInfo.duration}sec");

    await controller.addMarker(
      GeoPoint(latitude: 28.074922745459943, longitude: 74.6182404840264),
      markerIcon: MarkerIcon(
        icon: Icon(
          Icons.car_repair,
          color: Colors.black45,
          size: 48,
        ),
      ),
    );
    await controller.addMarker(
      GeoPoint(latitude: 28.074922745459943, longitude: 74.62228878378716),
      markerIcon: MarkerIcon(
        icon: Icon(
          Icons.car_repair,
          color: Colors.black45,
          size: 48,
        ),
      ),
    );
    await controller.addMarker(
      GeoPoint(latitude: 28.074922745459943, longitude: 74.61824048627),
      markerIcon: MarkerIcon(
        icon: Icon(
          Icons.car_repair,
          color: Colors.black45,
          size: 48,
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: appBar,
        body: Center(
          child: OSMFlutter(
            controller: controller,
            onLocationChanged: (GeoPoint point) {
              print('lat: ${point.latitude}, lon: ${point.longitude}');
              Rout_loc();
            },
            trackMyPosition: true,
            initZoom: 16,
            minZoomLevel: 6,
            maxZoomLevel: 19,
            stepZoom: 1.0,
            userLocationMarker: UserLocationMaker(
              personMarker: MarkerIcon(
                icon: Icon(
                  Icons.location_history_rounded,
                  color: Colors.red,
                  size: 48,
                ),
              ),
              directionArrowMarker: MarkerIcon(
                icon: Icon(
                  Icons.double_arrow,
                  size: 48,
                ),
              ),
            ),
            markerOption: MarkerOption(
              defaultMarker: MarkerIcon(
                icon: Icon(
                  Icons.person_pin_circle,
                  color: Colors.blue,
                  size: 56,
                ),
              ),
            ),
          ),
        ));
  }
}*/