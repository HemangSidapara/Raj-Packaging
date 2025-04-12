import 'dart:convert';

/// data : [{"date":"10-04-2025","meters":100,"kgs":150},{"date":"11-05-2025","meters":200,"kgs":250},{"date":"12-06-2025","meters":300,"kgs":350}]

GetProductionReportModel getProductionReportModelFromJson(String str) => GetProductionReportModel.fromJson(json.decode(str));

String getProductionReportModelToJson(GetProductionReportModel data) => json.encode(data.toJson());

class GetProductionReportModel {
  GetProductionReportModel({
    List<Data>? data,
  }) {
    _data = data;
  }

  GetProductionReportModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }

  List<Data>? _data;

  GetProductionReportModel copyWith({
    List<Data>? data,
  }) =>
      GetProductionReportModel(
        data: data ?? _data,
      );

  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// date : "10-04-2025"
/// meters : 100
/// kgs : 150

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    String? date,
    num? meters,
    num? kgs,
  }) {
    _date = date;
    _meters = meters;
    _kgs = kgs;
  }

  Data.fromJson(dynamic json) {
    _date = json['date'];
    _meters = json['meters'];
    _kgs = json['kgs'];
  }

  String? _date;
  num? _meters;
  num? _kgs;

  Data copyWith({
    String? date,
    num? meters,
    num? kgs,
  }) =>
      Data(
        date: date ?? _date,
        meters: meters ?? _meters,
        kgs: kgs ?? _kgs,
      );

  String? get date => _date;

  num? get meters => _meters;

  num? get kgs => _kgs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = _date;
    map['meters'] = _meters;
    map['kgs'] = _kgs;
    return map;
  }
}
