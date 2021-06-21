import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_maps/utils/map_style.dart';
import 'package:flutter_maps/widgets/custom_app_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../blocs/pages/home/bloc.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'home-page';
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // -18.0142941,-70.2661749
  final HomeBloc _bloc = HomeBloc();
  
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: this._bloc, 
      child: Scaffold(
        appBar: CustomAppBar(),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (_,state) {

                if (!state.gpsEnabled!) {
                  return Center(
                    child: Text(
                      "Para utilizar la app active el GPS",
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                if(state.loading!) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final CameraPosition _initialPosition = CameraPosition(
                  target: state.myLocation!,
                  zoom: 15
                );

                return Stack(
                  children: [
                    GoogleMap(
                      initialCameraPosition: _initialPosition,
                      zoomControlsEnabled: false,
                      compassEnabled: false,
                      // myLocationEnabled: false,
                      myLocationEnabled: true,
                      markers: state.markers!.values.toSet(),
                      polylines: state.polylines!.values.toSet(),
                      myLocationButtonEnabled: false,
                      polygons: state.polygons!.values.toSet(),
                      // onTap: (LatLng position) {
                      //   this._bloc.add(OnMapTap(position));
                      // },
                      onMapCreated: (GoogleMapController controller) {
                        this._bloc.setMapController(controller);
                      },
                    ),

                    Positioned(
                      bottom: 15,
                      right: 15,
                      child: FloatingActionButton(
                        onPressed: () => _bloc.goToMyPosition(),
                        child: Icon(
                          Icons.gps_fixed,
                          color: Colors.black,
                        ),
                        backgroundColor: Colors.white,
                      ),
                    )
                  ],
                );
              }
            )
          ),
        ),
      ),  
    );
  }
}