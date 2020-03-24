import 'package:flutter/material.dart';

// Api_Calling
import 'package:flutter_training_app/api_calling/google_maps_service.dart';

// Dependency
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

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
    GoogleMapsService googleMapsService = GoogleMapsService();

    static LatLng initialLatLng;
    LatLng initialPosition = initialLatLng;

    final Set<Marker> marker = {};
    final Set<Polyline> polyLine = {};

    TextEditingController locationController = TextEditingController();
    TextEditingController destinationController = TextEditingController();

    @override
    void initState() {
        // TODO: implement initState
        super.initState();
        this.getUserLocation();
    }

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

    // Summary: This function will decode the string received from the directions API.
    // Reference:
        //  1. http://wptrafficanalyzer.in/blog/route-between-two-locations-with-waypoints-in-google-map-android-api-v2/
        //  2. https://developers.google.com/maps/documentation/directions/start
    List _decodePoly(String poly) {
        var list = poly.codeUnits;
        var lList = new List();
        int index = 0;
        int len = poly.length;
        int c = 0;
        // repeating until all attributes are decoded.
        do {
            var shift = 0;
            int result = 0;

            // for decoding value of one attribute
            do {
                c = list[index] - 63;
                result |= (c & 0x1F) << (shift * 5);
                index++;
                shift++;
            } while (c >= 32);
            /* if value is negetive then bitwise not the value */
            if (result & 1 == 1) {
                result = ~result;
            }
            var result1 = (result >> 1) * 0.00001;
            lList.add(result1);
        } while (index < len);

        /*adding to previous value as done in encoding */
        for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

        print(lList.toString());

        return lList;
    }

    // Summary: This function will convert the output of decodePoly into LatLng object because decodePoly returns array of double values.
    /*
    * Suppose decodePoly returns [12.87(Lat), 55.08(Lng), 13.03(Lat), 87.13(Lng) ..... so on]. In the list two values corresponds to
    * LatLng object.
    * So convertToLatLng will return two object of LatLng inside a list.
    * */
    List<LatLng> convertToLatLng(List points){
        List<LatLng> result = <LatLng>[];
        for(int i = 0; i < points.length; i++){
            if(i % 2 == 0){
                result.add(LatLng(points[i-1], points[i]));
            }
        }
        return result;
    }

    // Summary: this function will provide the current location of user
    // Reference:
        // 1. https://github.com/Baseflow/flutter-geolocator
    void getUserLocation() async{

        Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        List<Placemark> placeMark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);

        setState(() {
            initialLatLng = LatLng(position.latitude, position.longitude);
            locationController.text = placeMark[0].name;
        });
    }

    @override
    Widget build(BuildContext context) {
        // TODO: implement build
        return initialLatLng == null ? Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
            ) : Stack(
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
                            top: 50.0,
                            right: 15.0,
                            left: 15.0,
                            child: Container(
                                height: 50.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3.0),
                                    color: Colors.white,
                                    boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(1.0, 5.0),
                                            blurRadius: 10,
                                            spreadRadius: 3)
                                    ],
                                ),
                                child: TextField(
                                    cursorColor: Colors.black,
                                    controller: locationController,
                                    decoration: InputDecoration(
                                        icon: Container(
                                            margin: EdgeInsets.only(left: 20, top: 5),
                                            width: 10,
                                            height: 10,
                                            child: Icon(
                                                Icons.location_on,
                                                color: Colors.black,
                                            ),
                                        ),
                                        hintText: "pick up",
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
                                    ),
                                ),
                            ),
                        ),

                        Positioned(
                            top: 105.0,
                            right: 15.0,
                            left: 15.0,
                            child: Container(
                                height: 50.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3.0),
                                    color: Colors.white,
                                    boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(1.0, 5.0),
                                            blurRadius: 10,
                                            spreadRadius: 3)
                                    ],
                                ),
                                child: TextField(
                                    cursorColor: Colors.black,
        //                            controller: appState.destinationController,
                                    textInputAction: TextInputAction.go,
        //                            onSubmitted: (value) {
        //                                appState.sendRequest(value);
        //                            },
                                    decoration: InputDecoration(
                                        icon: Container(
                                            margin: EdgeInsets.only(left: 20, top: 5),
                                            width: 10,
                                            height: 10,
                                            child: Icon(
                                                Icons.local_taxi,
                                                color: Colors.black,
                                            ),
                                        ),
                                        hintText: "destination?",
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
                                    ),
                                ),
                            ),
                    )
                ],
            );
    }
}