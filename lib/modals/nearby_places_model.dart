class NearbyPlacesModel {
  Geometry? geometry;
  String? icon;
  String? name;
  String? placeId;

  NearbyPlacesModel({
    this.geometry,
    this.icon,
    this.name,
    this.placeId,
  });

  @override
  String toString() {
    return 'Result(geometry: $geometry, icon: $icon, name: $name, placeId: $placeId,)';
  }

  factory NearbyPlacesModel.fromJson(Map<String, dynamic> json) => NearbyPlacesModel(
        geometry: json['geometry'] == null
            ? null
            : Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
        icon: json['icon'] as String?,
        name: json['name'] as String?,
        placeId: json['place_id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'geometry': geometry?.toJson(),
        'icon': icon,
        'name': name,
        'place_id': placeId,
      };

  NearbyPlacesModel copyWith({
    Geometry? geometry,
    String? icon,
    String? name,
    String? placeId,
  }) {
    return NearbyPlacesModel(
      geometry: geometry ?? this.geometry,
      icon: icon ?? this.icon,
      name: name ?? this.name,
      placeId: placeId ?? this.placeId,
    );
  }
}

class Geometry {
  Location? location;

  Geometry({this.location});

  @override
  String toString() => 'Geometry(location: $location)';

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        location: json['location'] == null
            ? null
            : Location.fromJson(json['location'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'location': location?.toJson(),
      };

  Geometry copyWith({
    Location? location,
  }) {
    return Geometry(
      location: location ?? this.location,
    );
  }
}

class Location {
  double? lat;
  double? lng;

  Location({this.lat, this.lng});

  @override
  String toString() => 'Location(lat: $lat, lng: $lng)';

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: (json['lat'] as num?)?.toDouble(),
        lng: (json['lng'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
      };

  Location copyWith({
    double? lat,
    double? lng,
  }) {
    return Location(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }
}
