class UserModel {
  String? sId;
  String? firstname;
  String? lastname;
  String? email;
  String? password;
  String? phone;
  String? address;
  int? iV;

  UserModel(
      {this.sId,
      this.firstname,
      this.lastname,
      this.email,
      this.password,
      this.phone,
      this.address,
      this.iV});

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    address = json['address'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['__v'] = this.iV;
    return data;
  }
}
