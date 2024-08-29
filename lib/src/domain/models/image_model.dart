import 'dart:typed_data';

class ImageModel {
  final int? id;
  final String? dateTime;
  final String? latitude;
  final String? longitude;
  final List<int>? imagePath;

  ImageModel({
    this.id,
    this.dateTime,
    this.latitude,
    this.longitude,
    this.imagePath,
  });

  factory ImageModel.fromJSON(Map<String, dynamic> json) {
    Uint8List? image = json["imagePath"];
    return ImageModel(
      id: json["id"],
      dateTime: json["dateTime"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      imagePath: image?.toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dateTime': dateTime,
      'latitude': latitude,
      'longitude': longitude,
      'imagePath': imagePath,
    };
  }
}
