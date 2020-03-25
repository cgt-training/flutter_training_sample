import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

// Summary: This key is generated from the google maps console account.
const apiKey = "AIzaSyCEplLkJx94Rq8ed7X2pa_NV2BX_WuG6ug";
// Summary: This class is used to call the google direction API for find the routes.
class GoogleMapsService{

    // Summary: This function will find the coordinates using the directions API.
    Future<String> getRouteCoordinates(LatLng l1, LatLng l2) async{
        String url = "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=$apiKey";
        http.Response response = await http.get(url);
        Map values = jsonDecode(response.body);
        return values["routes"][0]["overview_polyline"]["points"];
    }
}