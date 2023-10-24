class SalaryEventModel {
  List<Salary>? salary;
  List<Bonus>? bonus;
  List<Fine>? fine;

  SalaryEventModel({this.salary, this.bonus, this.fine});

  SalaryEventModel.fromJson(Map<String, dynamic> json) {
    if (json['salary'] != null) {
      salary = <Salary>[];
      json['salary'].forEach((v) {
        salary!.add(Salary.fromJson(v));
      });
    }
    if (json['bonus'] != null) {
      bonus = <Bonus>[];
      json['bonus'].forEach((v) {
        bonus!.add(Bonus.fromJson(v));
      });
    }
    if (json['fine'] != null) {
      fine = <Fine>[];
      json['fine'].forEach((v) {
        fine!.add(Fine.fromJson(v));
      });
    }
  }
}

class Salary {
  String? employee;
  String? date;
  String? salary;
  bool? paidLeaveSalary;
  bool? overtimeSalary;
  String? createdAt;

  Salary(
      {this.employee,
      this.date,
      this.salary,
      this.paidLeaveSalary,
      this.overtimeSalary,
      this.createdAt});

  Salary.fromJson(Map<String, dynamic> json) {
    employee = json['employee'];
    date = json['date'];
    salary = json['salary'];
    paidLeaveSalary = json['paid_leave_salary'];
    overtimeSalary = json['overtime_salary'];
    createdAt = json['created_at'];
  }
}

class Bonus {
  String? id;
  String? employee;
  String? addedBy;
  String? employeeName;
  String? createdAt;
  String? amount;
  String? comment;
  String? date;
  String? updatedAt;
  String? updatedBy;

  Bonus(
      {this.id,
      this.employee,
      this.addedBy,
      this.employeeName,
      this.createdAt,
      this.amount,
      this.comment,
      this.date,
      this.updatedAt,
      this.updatedBy});

  Bonus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employee = json['employee'];
    addedBy = json['added_by'];
    employeeName = json['employee_name'];
    createdAt = json['created_at'];
    amount = json['amount'];
    comment = json['comment'];
    date = json['date'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
  }
}

class Fine {
  String? id;
  String? employee;
  Null? addedBy;
  Null? finedBy;
  String? createdAt;
  String? amount;
  bool? paid;
  String? fineType;
  String? comment;
  String? date;
  String? updatedAt;
  String? updatedBy;

  Fine(
      {this.id,
      this.employee,
      this.addedBy,
      this.finedBy,
      this.createdAt,
      this.amount,
      this.paid,
      this.fineType,
      this.comment,
      this.date,
      this.updatedAt,
      this.updatedBy});

  Fine.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employee = json['employee'];
    addedBy = json['added_by'];
    finedBy = json['fined_by'];
    createdAt = json['created_at'];
    amount = json['amount'];
    paid = json['paid'];
    fineType = json['fine_type'];
    comment = json['comment'];
    date = json['date'];
    updatedAt = json['updated_at'];
    updatedBy = json['updated_by'];
  }
}
