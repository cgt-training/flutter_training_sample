import 'package:flutter/material.dart';

// Dependency
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Utils
import 'package:flutter_training_app/util/colors.dart';

// Summary: Stateful widget for map which will handle the state changes of map.
class MapsWithMarker extends StatefulWidget{

  @override
  MapsWithMarkerState createState() {
    // TODO: implement createState
    return MapsWithMarkerState();
  }
}

// Summary: Handles the state of map.
class MapsWithMarkerState extends State<MapsWithMarker>{

    GoogleMapController mapController;
    static const initialLatLng = LatLng(12.95, 77.58);
    LatLng initialPosition = initialLatLng;
    final Set<Marker> marker = {};

    // Summary: This function will provide custom map controller
    void onMapCreatedCustom(GoogleMapController controller) {
        setState(() {
            mapController = controller;
        });
    }

    // Summary: Handle the onPress event of add Marker button.
    void onAddMarkerPressed() {
        AlertDialog(
            title: Text("Dialog Box"),
        );
        setState(() {
            marker.add(
                Marker(
                    markerId: MarkerId(initialPosition.toString()),
                    position: initialPosition,
                    infoWindow: InfoWindow(
                        title: "My location",
                        snippet: "Destintion"
                    ),
                    icon: BitmapDescriptor.defaultMarker
                ));
        });
    }

    // Summary: This function will provide custom handling of camera position.
    void onCameraMoveCustom(CameraPosition position) {
        setState(() {
            initialPosition = position.target;
        });
    }

    @override
    Widget build(BuildContext context) {
        // TODO: implement build
        return Stack(
            children: <Widget>[
                GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: initialPosition,
                        zoom: 10.0
                    ),
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    onMapCreated: onMapCreatedCustom,
                    markers: marker,
                    onCameraMove: onCameraMoveCustom,
                ),
                Positioned(
                    top: 40,
                    right: 10,
                    child: FloatingActionButton(
                        onPressed: onAddMarkerPressed,
                        tooltip: "Add Marker",
                        backgroundColor: RallyColors.gray25a,
                        child: Icon(
                            Icons.add_location,
                            color: RallyColors.inputBg
                        ),
                    ),
                )
            ],
        );
    }
}