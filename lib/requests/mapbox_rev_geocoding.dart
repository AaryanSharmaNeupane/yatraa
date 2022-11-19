//access token is required here

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import '../helpers/dio_exceptions.dart';

String baseUrl = 'https://api.mapbox.com/geocoding/v5/mapbox.places';
String accessToken =
    "pk.eyJ1IjoicnVzdHUtbmV1cGFuZSIsImEiOiJjbGFnN3N4emgxY2VzM29ydHlhc2ozbW41In0.HterCgrAMUExckM18JX8ig";
Dio _dio = Dio();

Future getReverseGeocodingGivenLatLngUsingMapbox(LatLng latLng) async {
  String query = '${latLng.longitude},${latLng.latitude}';
  String url = '$baseUrl/$query.json?access_token=$accessToken';
  print(url);
  url = Uri.parse(url).toString();

  try {
    _dio.options.contentType = Headers.jsonContentType;
    final responseData = await _dio.get(url);
    print(responseData.data);
    return responseData.data;
  } catch (e) {
    final errorMessage = DioExceptions.fromDioError(e as DioError).toString();
    debugPrint(errorMessage);
  }
}
