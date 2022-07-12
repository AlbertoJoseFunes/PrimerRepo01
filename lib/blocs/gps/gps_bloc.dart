import 'dart:async';
import 'package:permission_handler/permission_handler.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {

  StreamSubscription? gpsServiceSubscribcion;
  
  GpsBloc() : super(const GpsState( isGpsEnabled: false, isGpsPermissionGrated: false) ) {
    
    on<GpsAndPermisionEvent>((event, emit) => emit(state.copyWith(
        isGpsEnabled: event.isGpsEnable,
        isGpsPermissionGrated: event.isGpsPermisionGranted
      
      ))
    );

    _init();
  }

  Future<void> _init() async {

    final gpsInitStatus = await Future.wait([
      _checkGpsStatus(),
      _isPermissionGranted(),
    ]);
    

    add(GpsAndPermisionEvent(
      isGpsEnable: gpsInitStatus[0],
      isGpsPermisionGranted: gpsInitStatus[1],
      ));
  }

  Future<bool> _isPermissionGranted() async {

    final isGranted = await Permission.location.isGranted;
    return isGranted;

  }




  Future <bool>_checkGpsStatus() async {

    final isEnable = await Geolocator.isLocationServiceEnabled();
      
    gpsServiceSubscribcion = Geolocator.getServiceStatusStream().listen((event) { 
      final isEnabled = (event.index == 1) ? true : false;
      add(GpsAndPermisionEvent(
      isGpsEnable: isEnabled,
      isGpsPermisionGranted: state.isGpsPermissionGrated
      ));
      
    });
    
    return isEnable;

  }


  Future<void> askGpsAccess() async {

    final status = await Permission.location.request();

    switch(status) {

      case PermissionStatus.granted:
        add(GpsAndPermisionEvent(isGpsEnable: state.isGpsEnabled, isGpsPermisionGranted: true));
        break;

      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        add(GpsAndPermisionEvent(isGpsEnable: state.isGpsEnabled, isGpsPermisionGranted: false ) );
        openAppSettings();

    }


  }


  
  @override
  Future<void> close() {
    gpsServiceSubscribcion?.cancel();
    return super.close();
  }


}
