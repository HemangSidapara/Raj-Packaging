import 'dart:convert';

/// code : "200"
/// msg : "get Top Paper, Paper And Flute Data Successfully"
/// Data : {"TopPaper":["100 gsm","150 gsm","180 gsm","230 gsm","250 gsm","Plastic"],"Paper":["100 gsm","150 gsm","180 gsm","230 gsm","250 gsm","Plastic"],"Flute":["100 gsm","150 gsm","180 gsm","230 gsm","250 gsm","Plastic"]}

GetPaperFluteModel getPaperFluteModelFromJson(String str) => GetPaperFluteModel.fromJson(json.decode(str));

String getPaperFluteModelToJson(GetPaperFluteModel data) => json.encode(data.toJson());

class GetPaperFluteModel {
  GetPaperFluteModel({
    String? code,
    String? msg,
    Data? data,}) {
    _code = code;
    _msg = msg;
    _data = data;
  }

  GetPaperFluteModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    _data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
  }

  String? _code;
  String? _msg;
  Data? _data;

  GetPaperFluteModel copyWith({ String? code,
    String? msg,
    Data? data,
  }) =>
      GetPaperFluteModel(code: code ?? _code,
        msg: msg ?? _msg,
        data: data ?? _data,
      );

  String? get code => _code;

  String? get msg => _msg;

  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['msg'] = _msg;
    if (_data != null) {
      map['Data'] = _data?.toJson();
    }
    return map;
  }

}

/// TopPaper : ["100 gsm","150 gsm","180 gsm","230 gsm","250 gsm","Plastic"]
/// Paper : ["100 gsm","150 gsm","180 gsm","230 gsm","250 gsm","Plastic"]
/// Flute : ["100 gsm","150 gsm","180 gsm","230 gsm","250 gsm","Plastic"]

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    List<String>? topPaper,
    List<String>? paper,
    List<String>? flute,}) {
    _topPaper = topPaper;
    _paper = paper;
    _flute = flute;
  }

  Data.fromJson(dynamic json) {
    _topPaper = json['TopPaper'] != null ? json['TopPaper'].cast<String>() : [];
    _paper = json['Paper'] != null ? json['Paper'].cast<String>() : [];
    _flute = json['Flute'] != null ? json['Flute'].cast<String>() : [];
  }

  List<String>? _topPaper;
  List<String>? _paper;
  List<String>? _flute;

  Data copyWith({ List<String>? topPaper,
    List<String>? paper,
    List<String>? flute,
  }) =>
      Data(topPaper: topPaper ?? _topPaper,
        paper: paper ?? _paper,
        flute: flute ?? _flute,
      );

  List<String>? get topPaper => _topPaper;

  List<String>? get paper => _paper;

  List<String>? get flute => _flute;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['TopPaper'] = _topPaper;
    map['Paper'] = _paper;
    map['Flute'] = _flute;
    return map;
  }

}