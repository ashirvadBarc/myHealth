// ignore_for_file: file_names

class UserModel {
  int? id;
  String? firstName;
  String? lastName;
  String? userName;
  String? password;
  String? email;
  String? phone;
  String? pin;
  String? dob;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.userName,
    this.password,
    this.email,
    this.phone,
    this.pin,
    this.dob,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      userName: json['userName'],
      password: json['password'],
      email: json['email'],
      phone: json['phone'],
      pin: json['pin'],
      dob: json['dob'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'password': password,
      'email': email,
      'phone': phone,
      'pin': pin,
      'dob': dob,
    };
  }
}
