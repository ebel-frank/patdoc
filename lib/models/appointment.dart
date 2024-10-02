class Appointment {
  String? physicianUid;
  String? physicianName;
  String? date;
  String? time;
  String? complaints;
  String? patientUid;
  String? patientName;
  String? patientEmail;

  Appointment({
    required this.physicianUid,
    required this.physicianName,
    required this.date,
    required this.time,
    required this.complaints,
    required this.patientUid,
    required this.patientName,
    required this.patientEmail,
  });

  Appointment.fromJson(Map<String, dynamic> json) {
    physicianUid = json['physicianUid'];
    physicianName = json['physicianName'];
    date = json['date'];
    time = json['time'];
    complaints = json['complaints'];
    patientUid = json['patientUid'];
    patientName = json['patientName'];
    patientEmail = json['patientEmail'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['physicianUid'] = physicianUid;
    data['physicianName'] = physicianName;
    data['date'] = date;
    data['time'] = time;
    data['complaints'] = complaints;
    data['patientUid'] = patientUid;
    data['patientName'] = patientName;
    data['patientEmail'] = patientEmail;
    return data;
  }

  @override
  String toString() {
    return 'Appointment(physicianUid: $physicianUid, physicianName: $physicianName, date: $date, time: $time, complaints: $complaints, patientUid: $patientUid, patientName: $patientName, patientEmail: $patientEmail)';
  }
}
