import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DashboardController extends GetxController {
  int selectedIndex = 0, bannerIndex = 0;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  List bottomItems = [Icons.home_filled, Icons.favorite_border, Icons.chat];
  var banner = [
    'https://media.istockphoto.com/id/638377134/photo/doctor-man-with-stethoscope-in-hospital.jpg?s=612x612&w=0&k=20&c=xldnHCxhAhi4VYWsrucaABm_jyUcn9vN1Azh2XcLQ_0=',
    'https://media.istockphoto.com/id/1210031774/photo/scientist-write-a-short-note-and-working-in-laboratory-with-team-medical-healthcare.jpg?s=612x612&w=0&k=20&c=cjohRPxhELd7l0BV-vZfpmMDVoPEZrHdnwIZcXISZ4I='
  ];

  bool loading = false,
      locationLoading = false,
      loadingCenter = false,
      called = false;
  TextEditingController searchController = TextEditingController(),
      mapContollrer = TextEditingController(),
      price = TextEditingController();

  Completer<GoogleMapController>? googleController;
  LatLng? userLocation;

  callAmbulance() {
    called = true;

    var markerU = Marker(
      markerId: const MarkerId('1'),
      position: userLocation!,
    );
    markers[const MarkerId('1')] = markerU;

    var markerD = const Marker(
      markerId: MarkerId('2'),
      position: LatLng(
        31.96091239999999,
        35.8987722,
      ),
    );
    markers[const MarkerId('2')] = markerD;
    update();
    animateMap(userLocation!.latitude, userLocation!.longitude, zoom: 12.0);
  }

  animateMap(double lat, double long, {double zoom = 16.0}) async {
    final GoogleMapController controller = await googleController!.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(lat, long), zoom: zoom),
    ));
  }

  center() async {
    loadingCenter = true;
    update();
    var d = await Geolocator.getCurrentPosition();
    Get.log(d.latitude.toString() + d.longitude.toString());
    animateMap(d.latitude, d.longitude);
    userLocation = LatLng(d.latitude, d.longitude);
    loadingCenter = false;
    update();
  }

  getUserLoaction({bool isloading = true}) async {
    if (isloading) {
      locationLoading = true;
      update();
    }

    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      locationLoading = false;
      update();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        locationLoading = false;
        update();
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      locationLoading = false;
      update();
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    var d = await Geolocator.getCurrentPosition();
    userLocation = LatLng(d.latitude, d.longitude);
    animateMap(d.latitude, d.longitude);
    Get.log(d.latitude.toString() + d.longitude.toString());
    locationLoading = false;
    update();
  }

  changeBannerIndex(x) {
    bannerIndex = x;
    update();
  }

  changeIndex(int x) {
    selectedIndex = x;
    update();
  }
}
