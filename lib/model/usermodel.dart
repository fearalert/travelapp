class UserModel {
  String? id;
  String? email;
  String? name;
  String? phoneNo;
  String? profileUrl;

  UserModel({
    this.id,
    this.email,
    this.name,
    this.phoneNo,
    this.profileUrl,
  });

// data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      name: map['name'],
      phoneNo: map['phoneNo'],
      profileUrl: map['profileUrl'],
    );
  }

// sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phoneNo': phoneNo,
      'profileUrl': profileUrl,
    };
  }
}

late UserModel userDetail;