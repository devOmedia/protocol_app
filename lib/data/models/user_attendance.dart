class BreaksSet {
  String? start;
  String? end;
  int? breakduration;

  BreaksSet({this.start, this.end, this.breakduration});

  BreaksSet.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    end = json['end'];
    breakduration = json['break_duration'];
  }
}

class Result {
  String? date;
  List<BreaksSet?>? breaksset;
  String? id;
  String? clockintime;
  String? clockouttime;
  int? ontimeclockin;
  int? ontimeclockout;
  bool? isOut;
  String? clockinstatus;
  String? clockoutstatus;
  int? workDuration;

  Result({
    this.date,
    this.breaksset,
    this.id,
    this.clockintime,
    this.clockouttime,
    this.ontimeclockin,
    this.ontimeclockout,
    this.isOut,
    this.clockinstatus,
    this.clockoutstatus,
    this.workDuration,
  });

  Result.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['breaks_set'] != null) {
      breaksset = <BreaksSet>[];
      json['breaks_set'].forEach((v) {
        breaksset!.add(BreaksSet.fromJson(v));
      });
    }
    id = json['id'];
    clockintime = json['clock_in_time'];
    clockouttime = json['clock_out_time'];
    ontimeclockin = json['on_time_clock_in'];
    ontimeclockout = json['on_time_clock_out'];
    isOut = json["out"];
    clockinstatus = json["clock_in_status"];
    clockoutstatus = json["clock_out_status"];
    workDuration = json["work_duration"];
  }
}

class Attendance {
  int? count;
  String? next;
  String? previous;
  List<Result?>? results;

  Attendance({this.count, this.next, this.previous, this.results});

  Attendance.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Result>[];
      json['results'].forEach((v) {
        results!.add(Result.fromJson(v));
      });
    }
  }
}
