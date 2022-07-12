part of 'gps_bloc.dart';

class GpsState extends Equatable {
  
  final bool isGpsEnabled;
  final bool isGpsPermissionGrated;

  bool get isAllGranted => isGpsEnabled && isGpsPermissionGrated;

  
  const GpsState({
   required this.isGpsEnabled, 
   required this.isGpsPermissionGrated
   });

   GpsState copyWith({
     bool? isGpsEnabled,
     bool? isGpsPermissionGrated,
   }) => GpsState(
    isGpsEnabled: isGpsEnabled ?? this.isGpsEnabled, 
    isGpsPermissionGrated: isGpsPermissionGrated ?? this.isGpsPermissionGrated
    );
  
  @override
  List<Object> get props => [ isGpsEnabled, isGpsPermissionGrated ];
}


