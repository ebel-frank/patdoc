class RemoticsUser {
  String? uid;
  String? firstName;
  String? lastName;
  String? gender;
  String? dateOfBirth;
  String? email;
  String? phoneNumber;
  String? userRole;
  String? physicianUid;

  RemoticsUser({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.dateOfBirth,
    required this.email,
    required this.phoneNumber,
    required this.userRole,
    this.physicianUid,
  });

  RemoticsUser.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    userRole = json['userRole'];
    physicianUid = json['physicianUid'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['uid'] = uid;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['gender'] = gender;
    data['dateOfBirth'] = dateOfBirth;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['userRole'] = userRole;
    data['physicianUid'] = physicianUid;
    return data;
  }
}
