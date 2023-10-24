class UserAdditionalInfo {
  String? name;
  String? officeStartTime;
  String? lastTimeToGiveAttendance;
  String? earliesttimetogiveattendance;
  UserAdditionalInfo(
      {this.name, this.officeStartTime, this.lastTimeToGiveAttendance});

  UserAdditionalInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    officeStartTime = json['office_start_time'];
    lastTimeToGiveAttendance = json['last_time_to_give_attendance'];
    earliesttimetogiveattendance = json["earliest_time_to_give_attendance"];
  }
}
