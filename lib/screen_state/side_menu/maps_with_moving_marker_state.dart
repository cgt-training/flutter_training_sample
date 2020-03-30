import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';

// Api_Calling
import 'package:flutter_training_app/api_calling/google_maps_service.dart';

// Dependency
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_webservice/places.dart';

// Utils
import 'package:flutter_training_app/util/colors.dart';


// Summary: Stateful widget for map which will handle the state changes of map.
class MapsWithMovingMarkerExample extends StatefulWidget{

    @override
    MapsWithMovingMarkerState createState() {
        // TODO: implement createState
        return MapsWithMovingMarkerState();
    }
}

// Summary: Handles the state of map.
class MapsWithMovingMarkerState extends State<MapsWithMovingMarkerExample> {

    GoogleMapController mapController;
    GoogleMapsService googleMapsService = GoogleMapsService();
    bool locationServiceActive = true;

    static LatLng initialLatLng;
    LatLng initialPosition = initialLatLng;

    Timer _timer;
    int lengthResultLatLng = 0;

    double CAMERA_ZOOM = 16;
    double CAMERA_TILT = 80;
    double CAMERA_BEARING = 30;
    List<LatLng> resultConvertLatLng = <LatLng>[];
    final Set<Marker> marker = {};
    Set<Marker> _markersUpdate = Set<Marker>();
    final Set<Polyline> polyLine = {};

    TextEditingController locationController = TextEditingController();
    TextEditingController destinationController = TextEditingController();

    @override
    void initState() {
        // TODO: implement initState
        super.initState();
        if(!mounted) {
            return;
        }else{
            this.getUserLocation();
            this.loadingInitialPosition();
        }
    }

    // Summary: this function will provide the current location of user
    // Reference:
    // 1. https://github.com/Baseflow/flutter-geolocator
    void getUserLocation() async{
        Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        List<Placemark> placeMark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
        if(!mounted) {
            return;
        }
        setState(() {
            initialLatLng = LatLng(position.latitude, position.longitude);
            locationController.text = placeMark[0].name;
        });
    }

    // Summary: Check if the location services are on or not after 5 seconds.
    void loadingInitialPosition() async{
        if(!mounted) {
            return;
        }
        await Future.delayed(Duration(seconds: 5)).then((v) {
            if(initialLatLng == null){
                setState(() {
                    locationServiceActive = false;
                });
            }
        });
    }


    // Summary: This function will provide custom map controller
    void onMapCreatedCustom(GoogleMapController controller) {
        setState(() {
            mapController = controller;
        });
    }

    // Summary: Handle the onPress event of add Marker button.
    void _addMarker(LatLng location, String address) {
        // Summary: Will set the required variables to set the marker.
        setState(() {
            marker.add(
                Marker(
                    markerId: MarkerId(initialPosition.toString()),
                    position: location,
                    infoWindow: InfoWindow(
                        title: address,
                        snippet: "Destination"
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
    List decodePoly(String poly) {
        print("List decodePoly(String poly)");
        print(poly);
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

//        print(lList.toString());

        return lList;
    }

    // Summary: This function will convert the output of decodePoly into LatLng object because decodePoly returns array of double values.
    /*
    * Suppose decodePoly returns [12.87(Lat), 55.08(Lng), 13.03(Lat), 87.13(Lng) ..... so on]. In the list two values corresponds to
    * LatLng object.
    * So convertToLatLng will return two object of LatLng inside a list.
    * */
    List<LatLng> convertToLatLng(List points){

//        List<LatLng> result = <LatLng>[];
        for(int i = 0; i < points.length; i++){
            if(i % 2 != 0){
                resultConvertLatLng.add(LatLng(points[i-1], points[i]));
            }
        }
        return resultConvertLatLng;
    }

    // ! SEND REQUEST
    void sendRequest(String intendedLocation) async {
        List<Placemark> placemark = await Geolocator().placemarkFromAddress(intendedLocation);
        double latitude = placemark[0].position.latitude;
        double longitude = placemark[0].position.longitude;
        LatLng destination = LatLng(latitude, longitude);
        _addMarker(destination, intendedLocation);
        String route = await googleMapsService.getRouteCoordinates(
            initialLatLng, destination);
        createRoute(route);
    }

    // Summary: This function will create the route using the polylines.
    void createRoute(String encondedPoly) {
        setState(() {
            polyLine.add(Polyline(
                polylineId: PolylineId(initialPosition.toString()),
                width: 5,
                points: convertToLatLng(decodePoly(encondedPoly)),
                color: Colors.black));
        });
    }

    void startTimerOfRoute() {
        lengthResultLatLng = 0;
        const oneSec = const Duration(seconds: 2);
        _timer = new Timer.periodic(
            oneSec,
                (Timer timer) => setState(
                    () {

                        lengthResultLatLng = lengthResultLatLng + 2;
                        print("updatePinOnMap");
                        updatePinOnMap(lengthResultLatLng);
                },
            ),
        );
    }

    void updatePinOnMap(int index){

        if (index >= ( resultConvertLatLng.length - 2 )){
            print("updatePinOnMap > 2");
            print(_timer);
            _timer.cancel();
        }else{
            CameraPosition cPosition = CameraPosition(
                zoom: CAMERA_ZOOM,
                tilt: CAMERA_TILT,
                bearing: CAMERA_BEARING,
                target: LatLng(resultConvertLatLng[index].latitude,
                    resultConvertLatLng[index].longitude),
            );
            mapController.animateCamera(CameraUpdate.newCameraPosition(cPosition));

            setState(() {      // updated position
                var pinPosition = LatLng(resultConvertLatLng[index].latitude,
                    resultConvertLatLng[index].longitude);

                // the trick is to remove the marker (by id)
                // and add it again at the updated location
                marker.removeWhere(
                        (m) => m.markerId.value == "sourcePin");
                marker.add(Marker(
                    markerId: MarkerId("sourcePin"),
                    position: pinPosition, // updated position
                    icon: BitmapDescriptor.defaultMarker
                ));
            });
        }
    }

    @override
    Widget build(BuildContext context) {
        // TODO: implement build
        print("length of Result lat lng");
        print(resultConvertLatLng.length);
        print(lengthResultLatLng);

        return initialLatLng == null ?
        Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
//                            CircularProgressIndicator()
                            SpinKitWave(
                                color: Colors.lightBlueAccent,
                                size: 50.0,
                            )
                        ],
                    ),
                    SizedBox(height: 10,),
                    Visibility(
                        visible: locationServiceActive == false,
                        child: Text("Please check location services!", style: TextStyle(color: Colors.grey, fontSize: 18),),
                    )
                ],
            )
        )
            : Stack(
            children: <Widget>[
                GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: initialLatLng,
                        zoom: 10.0
                    ),
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    onMapCreated: onMapCreatedCustom,
                    markers: marker,
                    onCameraMove: onCameraMoveCustom,
                    polylines: polyLine,
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
                            color: Colors.black12,
                            boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(1.0, 5.0),
                                    blurRadius: 10,
                                    spreadRadius: 3)
                            ],
                        ),
                        child: TextField(
                            cursorColor: Colors.black54,
                            controller: locationController,
                            decoration: InputDecoration(
                                icon: Container(
                                    width: 30,
                                    height: 50,
                                    child: Container(
                                        margin: EdgeInsets.only(top: 5, left: 12),
//                                                alignment: Alignment.center,
                                        child: Icon(
                                            Icons.location_on,
                                            color: Colors.black,
                                        ),
                                    ),
                                ),
                                hintText: "pick up",
                                hintStyle: TextStyle(
                                    color: Colors.black54
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 5.0),
                                fillColor: Colors.white
                            ),
                            style: TextStyle(
                                color: Colors.black45
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
                            color: Colors.black12,
                            boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(1.0, 5.0),
                                    blurRadius: 10,
                                    spreadRadius: 3)
                            ],
                        ),
                        child: TextField(
                            cursorColor: Colors.black54,
                            controller: destinationController,
                            textInputAction: TextInputAction.go,
                            onTap: ()async{
                                Prediction p = await PlacesAutocomplete.show(
                                    context: context,
                                    mode: Mode.overlay,
                                    apiKey: "AIzaSyCEplLkJx94Rq8ed7X2pa_NV2BX_WuG6ug",
                                    language: "en",
                                    components: [
                                        Component(Component.country, "in")
                                    ]
                                );
                                if(p !=null){
                                    print("Prediction PlacesAutocomplete");
                                    print(p.description);
                                    destinationController.text = p.description;
//                                            sendRequest(p.description);
                                }
                            },
                            onSubmitted: (value) {
                                sendRequest(value);
                            },
                            decoration: InputDecoration(
                                icon: Container(
                                    width: 30,
                                    height: 50,
                                    child: Container(
                                        margin: EdgeInsets.only(top: 5, left: 12),
//                                                alignment: Alignment.center,
                                        child: Icon(
                                            Icons.local_taxi,
                                            color: Colors.black,
                                        ),
                                    ),
                                ),
                                hintText: "destination?",
                                hintStyle: TextStyle(
                                    color: Colors.black45
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 5.0),
                                fillColor: Colors.white
                            ),
                            style: TextStyle(
                                color: Colors.black54
                            ),
                        ),

                    ),
                ),
                Visibility(
                    visible: resultConvertLatLng.length > 0,
                    child: Positioned(
                        bottom: 40,
                        right: 10,
                        child: FloatingActionButton(
                            onPressed: startTimerOfRoute,
                            tooltip: "Start Route",
                            backgroundColor: RallyColors.gray25a,
                            child: Icon(
                                Icons.add_location,
                                color: RallyColors.inputBg
                            ),
                        ),
                    ),
                )
            ],
        );
    }

    @override
    void dispose() {

        initialLatLng = null;
        _timer.cancel();
        // TODO: implement dispose
        super.dispose();
    }

}