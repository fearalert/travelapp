class AdminModel {
  String? id;
  String? email;
  String? name;
  String? phoneNo;
  String? token;

  AdminModel({this.id, this.email, this.name, this.phoneNo, this.token});

// data from server
  factory AdminModel.fromMap(map) {
    return AdminModel(
        id: map['id'],
        email: map['email'],
        name: map['name'],
        phoneNo: map['phoneNo'],
        token: map['token']);
  }
}

// AdminModel adminModel = AdminModel();
