import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:premedico/controller/dashboard_controller.dart';
import 'package:premedico/data/get_initial.dart';
import 'package:premedico/view/widget/custom_button.dart';
import 'package:premedico/view/widget/custom_loading.dart';

class CallAmbulanceScreen extends StatefulWidget {
  const CallAmbulanceScreen({
    super.key,
  });

  @override
  State<CallAmbulanceScreen> createState() => _CallAmbulanceScreenState();
}

class _CallAmbulanceScreenState extends State<CallAmbulanceScreen> {
  var dashboardController = Get.find<DashboardController>();

  @override
  void initState() {
    dashboardController.getUserLoaction(isloading: false);

    super.initState();
  }

  @override
  void dispose() {
    dashboardController.googleController = null;
    dashboardController.searchController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<DashboardController>(
      builder: (mapController) {
        return mapController.locationLoading
            ? const CustomLoading()
            : SizedBox(
                height: Get.height,
                width: Get.width,
                child: Stack(
                  children: [
                    GoogleMap(
                      markers: Set<Marker>.of(mapController.markers.values),
                      initialCameraPosition: CameraPosition(
                          target: dashboardController.userLocation ??
                              const LatLng(0, 0),
                          zoom: 16),
                      onMapCreated: (GoogleMapController controller) {
                        if (mapController.googleController == null) {
                          mapController.googleController =
                              Completer<GoogleMapController>();
                          mapController.googleController!.complete(controller);
                        }
                      },
                      onCameraMove: (position) {
                        dashboardController.userLocation = position.target;
                      },
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                    ),
                    Positioned(
                      top: 10,
                      left: 0,
                      right: 0,
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Container(
                                  height: 45,
                                  width: 45,
                                  margin: const EdgeInsets.only(right: 20),
                                  decoration: const BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 5,
                                            color: Colors.black12)
                                      ],
                                      color: Colors.white,
                                      shape: BoxShape.circle),
                                  child: IconButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      icon: const Icon(Icons.arrow_back))),
                              Flexible(
                                child: Container(
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black12,
                                            spreadRadius: 0.1,
                                            blurRadius: 5)
                                      ]),
                                  child: GooglePlacesAutoCompleteTextFormField(
                                    textEditingController:
                                        mapController.searchController,
                                    googleAPIKey:
                                        appConstant.androidGoogleMapKey,
                                    debounceTime: 400,
                                    countries: const ["jo"],
                                    decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 10),
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        hintText: 'search_address'.tr),
                                    itmClick: (postalCodeResponse) {},
                                    getPlaceDetailWithLatLng: (prediction) {
                                      mapController.searchController.text =
                                          prediction.description!;
                                      mapController.searchController.selection =
                                          TextSelection.fromPosition(
                                              TextPosition(
                                                  offset: prediction
                                                      .description!.length));

                                      dashboardController.animateMap(
                                        double.parse(prediction.lat!),
                                        double.parse(prediction.lng!),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 10,
                        right: 0,
                        left: 0,
                        child: SafeArea(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomButton(
                                onPressed: () async {
                                  mapController.searchController.clear();

                                  mapController.callAmbulance();
                                },
                                title: 'call_ambulance',
                                loading: mapController.loading,
                                width: Get.width * 0.75,
                              ),
                              FloatingActionButton(
                                onPressed: () {
                                  if (!mapController.loadingCenter) {
                                    mapController.center();
                                  }
                                },
                                backgroundColor: appConstant.primaryColor,
                                child: mapController.loadingCenter
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const Icon(
                                        Icons.my_location_rounded,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                              )
                            ],
                          ),
                        )),
                    if (!mapController.called)
                      const Center(
                          child: Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 35,
                      )),
                  ],
                ),
              );
      },
    ));
  }
}
