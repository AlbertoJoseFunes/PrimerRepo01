part of 'gps_bloc.dart';

abstract class GpsEvent extends Equatable {
  const GpsEvent();

  @override
  List<Object> get props => [];
}


class GpsAndPermisionEvent extends GpsEvent {

final bool isGpsEnable;
final bool isGpsPermisionGranted;

  const GpsAndPermisionEvent({
    required this.isGpsEnable,
    required this.isGpsPermisionGranted});

  


}