class JoiningData {
  String? employeeId;
  String? date;

  JoiningData({this.employeeId, this.date});

  JoiningData.fromJson(Map<String, dynamic> json) {
    employeeId = json['employee_id'];
    date = json['date'];
  }
}
