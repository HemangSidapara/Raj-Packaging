import 'dart:convert';

/// code : "200"
/// msg : "get Job Data Successfully"
/// Tabs : [{"Corrugation - Pesting":[{"orderId":"1","jobId":"1","description":"Sheet Size : 48 X 49.5, Flute : 100 gsm, Paper : 100 gsm,Top Paper : 180 gsm, Ply : 5, Qty : 1250 Liner"},{"orderId":"2","jobId":"5","description":"Sheet Size : 44 X 45.5, Flute : 100 gsm, Paper : 100 gsm,Top Paper : 180 gsm, Ply : 3, Qty : 525 Liner"}],"Paper Cutting":[{"orderId":"1","jobId":"2","description":"Size : 48X49.5, Top Paper : 180 gsm Top Paper, Qty : 250"},{"orderId":"2","jobId":"6","description":"Size : 44X45.5, Top Paper : 180 gsm Top Paper, Qty : 175"}],"Slitting - Scoring":[{"orderId":"1","jobId":"4","description":"Sheet Size : 48X49.5, Ply :  5, Top Paper :  180 gsm Top Paper, Order Size : 12X12X12, Joint : "},{"orderId":"2","jobId":"8","description":"Sheet Size : 44X45.5, Ply :  3, Top Paper :  180 gsm Top Paper, Order Size : 11X11X11, Joint : "}],"Flexo Printing":[{"orderId":"1","jobId":"4","description":"Sheet Size : 48X49.5, Ply :  5, Top Paper :  180 gsm Top Paper, Order Size : 12X12X12, Joint : "},{"orderId":"2","jobId":"8","description":"Sheet Size : 44X45.5, Ply :  3, Top Paper :  180 gsm Top Paper, Order Size : 11X11X11, Joint : "}],"Die Punching":[{"orderId":"1","jobId":"4","description":"Sheet Size : 48X49.5, Ply :  5, Top Paper :  180 gsm Top Paper, Order Size : 12X12X12, Joint : "},{"orderId":"2","jobId":"8","description":"Sheet Size : 44X45.5, Ply :  3, Top Paper :  180 gsm Top Paper, Order Size : 11X11X11, Joint : "}]}]

GetJobDataModel getJobDataModelFromJson(String str) => GetJobDataModel.fromJson(json.decode(str));
String getJobDataModelToJson(GetJobDataModel data) => json.encode(data.toJson());

class GetJobDataModel {
  GetJobDataModel({
    String? code,
    String? msg,
    List<Tabs>? tabs,
  }) {
    _code = code;
    _msg = msg;
    _tabs = tabs;
  }

  GetJobDataModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    if (json['Tabs'] != null) {
      _tabs = [];
      json['Tabs'].forEach((v) {
        _tabs?.add(Tabs.fromJson(v));
      });
    }
  }
  String? _code;
  String? _msg;
  List<Tabs>? _tabs;
  GetJobDataModel copyWith({
    String? code,
    String? msg,
    List<Tabs>? tabs,
  }) =>
      GetJobDataModel(
        code: code ?? _code,
        msg: msg ?? _msg,
        tabs: tabs ?? _tabs,
      );
  String? get code => _code;
  String? get msg => _msg;
  List<Tabs>? get tabs => _tabs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['msg'] = _msg;
    if (_tabs != null) {
      map['Tabs'] = _tabs?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// Corrugation - Pesting : [{"orderId":"1","jobId":"1","description":"Sheet Size : 48 X 49.5, Flute : 100 gsm, Paper : 100 gsm,Top Paper : 180 gsm, Ply : 5, Qty : 1250 Liner"},{"orderId":"2","jobId":"5","description":"Sheet Size : 44 X 45.5, Flute : 100 gsm, Paper : 100 gsm,Top Paper : 180 gsm, Ply : 3, Qty : 525 Liner"}]
/// Paper Cutting : [{"orderId":"1","jobId":"2","description":"Size : 48X49.5, Top Paper : 180 gsm Top Paper, Qty : 250"},{"orderId":"2","jobId":"6","description":"Size : 44X45.5, Top Paper : 180 gsm Top Paper, Qty : 175"}]
/// Slitting - Scoring : [{"orderId":"1","jobId":"4","description":"Sheet Size : 48X49.5, Ply :  5, Top Paper :  180 gsm Top Paper, Order Size : 12X12X12, Joint : "},{"orderId":"2","jobId":"8","description":"Sheet Size : 44X45.5, Ply :  3, Top Paper :  180 gsm Top Paper, Order Size : 11X11X11, Joint : "}]
/// Flexo Printing : [{"orderId":"1","jobId":"4","description":"Sheet Size : 48X49.5, Ply :  5, Top Paper :  180 gsm Top Paper, Order Size : 12X12X12, Joint : "},{"orderId":"2","jobId":"8","description":"Sheet Size : 44X45.5, Ply :  3, Top Paper :  180 gsm Top Paper, Order Size : 11X11X11, Joint : "}]
/// Die Punching : [{"orderId":"1","jobId":"4","description":"Sheet Size : 48X49.5, Ply :  5, Top Paper :  180 gsm Top Paper, Order Size : 12X12X12, Joint : "},{"orderId":"2","jobId":"8","description":"Sheet Size : 44X45.5, Ply :  3, Top Paper :  180 gsm Top Paper, Order Size : 11X11X11, Joint : "}]

Tabs tabsFromJson(String str) => Tabs.fromJson(json.decode(str));
String tabsToJson(Tabs data) => json.encode(data.toJson());

class Tabs {
  Tabs({
    List<CorrugationPesting>? corrugationPesting,
    List<PaperCutting>? paperCutting,
    List<SlittingScoring>? slittingScoring,
    List<FlexoPrinting>? flexoPrinting,
    List<DiePunching>? diePunching,
  }) {
    _corrugationPesting = corrugationPesting;
    _paperCutting = paperCutting;
    _slittingScoring = slittingScoring;
    _flexoPrinting = flexoPrinting;
    _diePunching = diePunching;
  }

  Tabs.fromJson(dynamic json) {
    if (json['Corrugation - Pesting'] != null) {
      _corrugationPesting = [];
      json['Corrugation - Pesting'].forEach((v) {
        _corrugationPesting?.add(CorrugationPesting.fromJson(v));
      });
    }
    if (json['Paper Cutting'] != null) {
      _paperCutting = [];
      json['Paper Cutting'].forEach((v) {
        _paperCutting?.add(PaperCutting.fromJson(v));
      });
    }
    if (json['Slitting - Scoring'] != null) {
      _slittingScoring = [];
      json['Slitting - Scoring'].forEach((v) {
        _slittingScoring?.add(SlittingScoring.fromJson(v));
      });
    }
    if (json['Flexo Printing'] != null) {
      _flexoPrinting = [];
      json['Flexo Printing'].forEach((v) {
        _flexoPrinting?.add(FlexoPrinting.fromJson(v));
      });
    }
    if (json['Die Punching'] != null) {
      _diePunching = [];
      json['Die Punching'].forEach((v) {
        _diePunching?.add(DiePunching.fromJson(v));
      });
    }
  }
  List<CorrugationPesting>? _corrugationPesting;
  List<PaperCutting>? _paperCutting;
  List<SlittingScoring>? _slittingScoring;
  List<FlexoPrinting>? _flexoPrinting;
  List<DiePunching>? _diePunching;
  Tabs copyWith({
    List<CorrugationPesting>? corrugationPesting,
    List<PaperCutting>? paperCutting,
    List<SlittingScoring>? slittingScoring,
    List<FlexoPrinting>? flexoPrinting,
    List<DiePunching>? diePunching,
  }) =>
      Tabs(
        corrugationPesting: corrugationPesting ?? _corrugationPesting,
        paperCutting: paperCutting ?? _paperCutting,
        slittingScoring: slittingScoring ?? _slittingScoring,
        flexoPrinting: flexoPrinting ?? _flexoPrinting,
        diePunching: diePunching ?? _diePunching,
      );
  List<CorrugationPesting>? get corrugationPesting => _corrugationPesting;
  List<PaperCutting>? get paperCutting => _paperCutting;
  List<SlittingScoring>? get slittingScoring => _slittingScoring;
  List<FlexoPrinting>? get flexoPrinting => _flexoPrinting;
  List<DiePunching>? get diePunching => _diePunching;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_corrugationPesting != null) {
      map['Corrugation - Pesting'] = _corrugationPesting?.map((v) => v.toJson()).toList();
    }
    if (_paperCutting != null) {
      map['Paper Cutting'] = _paperCutting?.map((v) => v.toJson()).toList();
    }
    if (_slittingScoring != null) {
      map['Slitting - Scoring'] = _slittingScoring?.map((v) => v.toJson()).toList();
    }
    if (_flexoPrinting != null) {
      map['Flexo Printing'] = _flexoPrinting?.map((v) => v.toJson()).toList();
    }
    if (_diePunching != null) {
      map['Die Punching'] = _diePunching?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// orderId : "1"
/// jobId : "4"
/// description : "Sheet Size : 48X49.5, Ply :  5, Top Paper :  180 gsm Top Paper, Order Size : 12X12X12, Joint : "

DiePunching diePunchingFromJson(String str) => DiePunching.fromJson(json.decode(str));
String diePunchingToJson(DiePunching data) => json.encode(data.toJson());

class DiePunching {
  DiePunching({
    String? orderId,
    String? jobId,
    String? description,
  }) {
    _orderId = orderId;
    _jobId = jobId;
    _description = description;
  }

  DiePunching.fromJson(dynamic json) {
    _orderId = json['orderId'];
    _jobId = json['jobId'];
    _description = json['description'];
  }
  String? _orderId;
  String? _jobId;
  String? _description;
  DiePunching copyWith({
    String? orderId,
    String? jobId,
    String? description,
  }) =>
      DiePunching(
        orderId: orderId ?? _orderId,
        jobId: jobId ?? _jobId,
        description: description ?? _description,
      );
  String? get orderId => _orderId;
  String? get jobId => _jobId;
  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['orderId'] = _orderId;
    map['jobId'] = _jobId;
    map['description'] = _description;
    return map;
  }
}

/// orderId : "1"
/// jobId : "4"
/// description : "Sheet Size : 48X49.5, Ply :  5, Top Paper :  180 gsm Top Paper, Order Size : 12X12X12, Joint : "

FlexoPrinting flexoPrintingFromJson(String str) => FlexoPrinting.fromJson(json.decode(str));
String flexoPrintingToJson(FlexoPrinting data) => json.encode(data.toJson());

class FlexoPrinting {
  FlexoPrinting({
    String? orderId,
    String? jobId,
    String? description,
  }) {
    _orderId = orderId;
    _jobId = jobId;
    _description = description;
  }

  FlexoPrinting.fromJson(dynamic json) {
    _orderId = json['orderId'];
    _jobId = json['jobId'];
    _description = json['description'];
  }
  String? _orderId;
  String? _jobId;
  String? _description;
  FlexoPrinting copyWith({
    String? orderId,
    String? jobId,
    String? description,
  }) =>
      FlexoPrinting(
        orderId: orderId ?? _orderId,
        jobId: jobId ?? _jobId,
        description: description ?? _description,
      );
  String? get orderId => _orderId;
  String? get jobId => _jobId;
  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['orderId'] = _orderId;
    map['jobId'] = _jobId;
    map['description'] = _description;
    return map;
  }
}

/// orderId : "1"
/// jobId : "4"
/// description : "Sheet Size : 48X49.5, Ply :  5, Top Paper :  180 gsm Top Paper, Order Size : 12X12X12, Joint : "

SlittingScoring slittingScoringFromJson(String str) => SlittingScoring.fromJson(json.decode(str));
String slittingScoringToJson(SlittingScoring data) => json.encode(data.toJson());

class SlittingScoring {
  SlittingScoring({
    String? orderId,
    String? jobId,
    String? description,
  }) {
    _orderId = orderId;
    _jobId = jobId;
    _description = description;
  }

  SlittingScoring.fromJson(dynamic json) {
    _orderId = json['orderId'];
    _jobId = json['jobId'];
    _description = json['description'];
  }
  String? _orderId;
  String? _jobId;
  String? _description;
  SlittingScoring copyWith({
    String? orderId,
    String? jobId,
    String? description,
  }) =>
      SlittingScoring(
        orderId: orderId ?? _orderId,
        jobId: jobId ?? _jobId,
        description: description ?? _description,
      );
  String? get orderId => _orderId;
  String? get jobId => _jobId;
  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['orderId'] = _orderId;
    map['jobId'] = _jobId;
    map['description'] = _description;
    return map;
  }
}

/// orderId : "1"
/// jobId : "2"
/// description : "Size : 48X49.5, Top Paper : 180 gsm Top Paper, Qty : 250"

PaperCutting paperCuttingFromJson(String str) => PaperCutting.fromJson(json.decode(str));
String paperCuttingToJson(PaperCutting data) => json.encode(data.toJson());

class PaperCutting {
  PaperCutting({
    String? orderId,
    String? jobId,
    String? description,
  }) {
    _orderId = orderId;
    _jobId = jobId;
    _description = description;
  }

  PaperCutting.fromJson(dynamic json) {
    _orderId = json['orderId'];
    _jobId = json['jobId'];
    _description = json['description'];
  }
  String? _orderId;
  String? _jobId;
  String? _description;
  PaperCutting copyWith({
    String? orderId,
    String? jobId,
    String? description,
  }) =>
      PaperCutting(
        orderId: orderId ?? _orderId,
        jobId: jobId ?? _jobId,
        description: description ?? _description,
      );
  String? get orderId => _orderId;
  String? get jobId => _jobId;
  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['orderId'] = _orderId;
    map['jobId'] = _jobId;
    map['description'] = _description;
    return map;
  }
}

/// orderId : "1"
/// jobId : "1"
/// description : "Sheet Size : 48 X 49.5, Flute : 100 gsm, Paper : 100 gsm,Top Paper : 180 gsm, Ply : 5, Qty : 1250 Liner"

CorrugationPesting corrugationPestingFromJson(String str) => CorrugationPesting.fromJson(json.decode(str));
String corrugationPestingToJson(CorrugationPesting data) => json.encode(data.toJson());

class CorrugationPesting {
  CorrugationPesting({
    String? orderId,
    String? jobId,
    String? description,
  }) {
    _orderId = orderId;
    _jobId = jobId;
    _description = description;
  }

  CorrugationPesting.fromJson(dynamic json) {
    _orderId = json['orderId'];
    _jobId = json['jobId'];
    _description = json['description'];
  }
  String? _orderId;
  String? _jobId;
  String? _description;
  CorrugationPesting copyWith({
    String? orderId,
    String? jobId,
    String? description,
  }) =>
      CorrugationPesting(
        orderId: orderId ?? _orderId,
        jobId: jobId ?? _jobId,
        description: description ?? _description,
      );
  String? get orderId => _orderId;
  String? get jobId => _jobId;
  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['orderId'] = _orderId;
    map['jobId'] = _jobId;
    map['description'] = _description;
    return map;
  }
}
