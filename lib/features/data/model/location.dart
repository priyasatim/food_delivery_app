class UserLocation {
  final double latitude;
  final double longitude;
  final String address;
  final String area;

  UserLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.area,
  });

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'area': area,
    };
  }

  factory UserLocation.fromMap(Map<String, dynamic> map) {
    return UserLocation(
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
      address: map['address'],
      area: map['area'],
    );
  }
}