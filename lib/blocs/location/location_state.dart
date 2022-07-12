part of 'location_bloc.dart';

 class LocationState extends Equatable {
  

  final bool followinUser;
  // TODO:
  // ultimo geolocation
  // historia de la utima ubicacion
  
  const LocationState({
      this.followinUser = false
    });
    
 
 
  @override
  List<Object> get props => [followinUser];
}


