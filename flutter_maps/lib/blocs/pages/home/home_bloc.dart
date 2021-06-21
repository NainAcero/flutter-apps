import 'dart:async';
import 'dart:typed_data';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/models/place.dart';
import 'package:flutter_maps/utils/extras.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_maps/blocs/pages/home/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_permissions/location_permissions.dart';

class HomeBloc extends Bloc<HomeEvents, HomeState> {

  Geolocator _geolocator = Geolocator();
  // final Completer<Marker> _myPositionMarker = Completer();

  final LocationPermissions _locationPermissions = LocationPermissions();
  Completer<GoogleMapController> _completer = Completer();

  Future<GoogleMapController> get _mapController async {
    return await _completer.future;
  }
  
  StreamSubscription<Position>? _subscription;
  StreamSubscription<ServiceStatus>? _subscriptionGpsStatus;

  // Polyline myRoute = Polyline(
  //   polylineId: PolylineId('my_route'),
  //   width: 5,
  //   color: Colors.redAccent,
  // );

  // Polygon myTaps = Polygon(
  //   polygonId: PolygonId('my_taps_polygon'),
  //   fillColor: Colors.redAccent,
  //   strokeWidth: 3,
  //   strokeColor: Colors.white
  // );
  
  HomeBloc() : super(HomeState.initialState) {
    this._init();
  }

  _init() async {

    // this._loadCarPin();

    if(Platform.isAndroid) {

      _subscriptionGpsStatus =
          _locationPermissions.serviceStatus.listen((status) {
            
        if(status == ServiceStatus.enabled) {
          print("_listener");
          _subscription?.cancel();
          this._listener();
        }
        add(
          OnGpsEnabled(status == ServiceStatus.enabled),
        );
      });
    } else if(Platform.isIOS) {
      this._listener();
    }
  }

  _listener(){
    _subscription = Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.high,
      distanceFilter: 10
    ).listen(
    (Position? position) async {
        if (position != null) {
          final newPosition = LatLng(position.latitude, position.longitude);
          add(OnMyLocationUpdate(newPosition,),);

          final CameraUpdate cameraUpdate = CameraUpdate.newLatLng(newPosition);
          await (await _mapController).animateCamera(cameraUpdate);
        }
    });
  }

  @override
  Future<void> close() async {
    _subscription?.cancel();
    _subscriptionGpsStatus?.cancel();
    super.close();
  }

  goToMyPosition() async {
    if (this.state.myLocation != null) {
      final CameraUpdate cameraUpdate =
          CameraUpdate.newLatLng(this.state.myLocation!);
      await (await _mapController).animateCamera(cameraUpdate);
    }
  }

  goToPlace(Place place) async {
    await Future.delayed(Duration(milliseconds: 300));
    add(GoToPlace(place));
    final CameraUpdate cameraUpdate = CameraUpdate.newLatLng(place.position);
    await (await _mapController).animateCamera(cameraUpdate);
  }

  // _loadCarPin() async {
  //   final Uint8List bytes = await loadAsset('assets/car-pin.png', width: 40);
  //   final marker = Marker(
  //     markerId: MarkerId('my_position_marker'),
  //     icon: BitmapDescriptor.fromBytes(bytes),
  //     anchor: Offset(0.5, 0.5),
  //   );
  //   this._myPositionMarker.complete(marker);
  // }

  void setMapController(GoogleMapController controller) {
    if (_completer.isCompleted) {
      _completer = Completer();
    }
    _completer.complete(controller);
  }

  @override
  HomeState get initialState => HomeState.initialState;

  @override
  Stream<HomeState> mapEventToState(HomeEvents event) async* {
    if(event is OnMyLocationUpdate) {
      yield* this._mapOnMyLocationUpdate(event);
    } else if(event is OnGpsEnabled){
      yield this.state.copyWith(gpsEnabled: event.enabled);
    } else if (event is GoToPlace) {
      final history = Map<String, Place>.from(this.state.history!);
      final MarkerId markerId = MarkerId('place');

      final Uint8List bytes = await placeToMarker(event.place);

      final Marker marker = Marker(
        markerId: markerId,
        position: event.place.position,
        icon: BitmapDescriptor.fromBytes(bytes),
        // infoWindow: InfoWindow(
        //   title: event.place.title,
        //   snippet: event.place.vicinity.replaceAll('<br/>', ' - ')
        // )
      );

      final markers = Map<MarkerId, Marker>.from(this.state.markers!);
      markers[markerId] = marker;

      if (history[event.place.id] == null) {
        history[event.place.id] = event.place;
        yield this.state.copyWith(history: history,markers: markers,);
      } else {
        yield this.state.copyWith(markers: markers);
      }
    }
    // } else if (event is OnMapTap) {
    //   yield* this._mapOnMapTap(event);
    // }
  }

  Stream<HomeState> _mapOnMyLocationUpdate(OnMyLocationUpdate event) async* {
    // List<LatLng> points = List<LatLng>.from(this.myRoute.points);
    // points.add(event.location);

    // this.myRoute = this.myRoute.copyWith(pointsParam: points);
    // print("points ${this.myRoute.points.length}");

    // Map<PolylineId, Polyline> polylines =
    //     Map<PolylineId, Polyline>.from(this.state.polylines!);
    
    // polylines[this.myRoute.polylineId] = this.myRoute;

    // final markers = Map<MarkerId, Marker>.from(this.state.markers!);

    // double rotation = 0;
    // LatLng? lastPosition = this.state.myLocation;
    // if (lastPosition != null) {
    //   rotation = getCoordsRotation(event.location, lastPosition);
    // }

    // final Marker myPositionMarker =
    //     (await this._myPositionMarker.future).copyWith(
    //   positionParam: event.location,
    //   rotationParam: rotation,
    // );

    // markers[myPositionMarker.markerId] = myPositionMarker;

    // yield this.state.copyWith(
    //     loading: false,
    //     myLocation: event.location,
    //     polylines: polylines,
    //     markers: markers
    //   );
    yield this.state.copyWith(
        loading: false,
        myLocation: event.location
      );
  }

  // Stream<HomeState> _mapOnMapTap(OnMapTap event) async* {
  //   final markerId = MarkerId(this.state.markers!.length.toString());
  //   final info = InfoWindow(
  //     title: "HEllO ${markerId.value}",
  //     snippet: "la direcccion etc etc",
  //   );
    
  //   final Uint8List bytes = 
  //       await loadImageFromNetwork(Uri.parse("https://www.neappoli.com/static/media/flutterImg.94b8139a.png"),
  //       width: 100,
  //       height: 100);
    
  //   final customIcon = BitmapDescriptor.fromBytes(bytes);

  //   final marker = Marker(
  //     markerId: markerId, 
  //     position: event.location, 
  //     icon: customIcon,
  //     anchor: Offset(0.5, 0.5),
  //     onTap: () {
  //       print("${markerId.value}");
  //     },
  //     draggable: true,
  //     onDragEnd: (LatLng newPosition) {
  //       print("${newPosition}");
  //     },
  //     infoWindow: info,
  //   );

  //   final markers = Map<MarkerId, Marker>.from(this.state.markers!);
  //   markers[markerId] = marker;

  //   List<LatLng> points = List<LatLng>.from(this.myTaps.points);
  //   points.add(event.location);
  //   this.myTaps = this.myTaps.copyWith(pointsParam: points);
  //   Map<PolygonId, Polygon> polygons =
  //       Map<PolygonId, Polygon>.from(this.state.polygons!);
  //   polygons[this.myTaps.polygonId] = this.myTaps;

  //   yield this.state.copyWith(markers: markers, polygons: polygons);
  // }

}