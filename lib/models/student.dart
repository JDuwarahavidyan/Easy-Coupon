

class ReportDataModel {
  final String Number;
  final String Time;
  final String Date; // Date is now a string

  ReportDataModel(
      {required this.Number, required this.Time, required this.Date});

  factory ReportDataModel.fromJson(Map<String, dynamic> json) {
    return ReportDataModel(
      Number: json['Number'],
      Time: json['Time'],
      Date: json['Date'],
    );
  }
}
