import 'package:cloud_firestore/cloud_firestore.dart';

class PlacesDetails {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  String? placeName;
  String? locationName;
  String? imgUrl;
  String? placeDescription;
  String? startPointName;
  String? endPointName;
  double? price;

  PlacesDetails({
    this.placeName,
    this.locationName,
    this.imgUrl,
    this.placeDescription,
    this.startPointName,
    this.endPointName,
    this.price,
  });

  factory PlacesDetails.fromMap(map) {
    return PlacesDetails(
      placeName: map['placeName'],
      locationName: map['locationName'],
      imgUrl: map['imgUrl'],
      placeDescription: map['placeDescription'],
      startPointName: map['startPointName'],
      endPointName: map['endPointName'],
      price: map['price'],
    );
  }
}

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
PlacesDetails placesDetails = PlacesDetails();
