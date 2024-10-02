class Token {
  String? token;
  String? physicianEmail;
  String? physicianUid;
  String? physicianFullName;

  Token({
    required this.token,
    required this.physicianEmail,
    required this.physicianUid,
    required this.physicianFullName,
  });

  Token.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    physicianEmail = json['physicianEmail'];
    physicianUid = json['physicianUid'];
    physicianFullName = json['physicianFullName'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['token'] = token;
    data['physicianEmail'] = physicianEmail;
    data['physicianUid'] = physicianUid;
    data['physicianFullName'] = physicianFullName;
    return data;
  }

  @override
  String toString() {
    return 'Token{token: $token, physicianEmail: $physicianEmail, physicianUid: $physicianUid, physicianFullName: $physicianFullName}';
  }
}
