import 'dart:convert';

/// code : "200"
/// msg : "get Orders Successfully"
/// Data : [{"partyId":"1","partyName":"delicate foods","partyPhone":"9638879056","productData":[{"productId":"1","orderType":"Box","boxType":"RSC","deckle":"24.00","cutting":"49.50","productName":"no 1 outer","ply":"5","topPaper":"180 gsm","paper":"100 gsm","flute":"100 gsm","l":"12","b":"12","h":"12","productionCutting":"49.5","productionDeckle":"48","joint":"","orderData":[{"orderId":"1","orderQuantity":"500","productionQuantity":"250","status":"In Progress","createdDate":"2024-07-03","createdTime":"15:31:29","jobData":[{"jobId":"11","jobName":"Corrugation","status":"Pending","createdDate":"2024-07-28","createdTime":"12:24:07"},{"jobId":"12","jobName":"Paper Cutting","status":"Pending","createdDate":"2024-07-28","createdTime":"12:24:07"},{"jobId":"13","jobName":"Pesting","status":"Pending","createdDate":"2024-07-28","createdTime":"12:24:07"},{"jobId":"14","jobName":"Slitting - Scoring","status":"Pending","createdDate":"2024-07-28","createdTime":"12:24:07"},{"jobId":"15","jobName":"","status":"Pending","createdDate":"2024-07-28","createdTime":"12:24:07"},{"jobId":"16","jobName":"Corrugation","status":"Pending","createdDate":"2024-07-28","createdTime":"12:24:48"},{"jobId":"17","jobName":"Paper Cutting","status":"Pending","createdDate":"2024-07-28","createdTime":"12:24:48"},{"jobId":"18","jobName":"Pesting","status":"Pending","createdDate":"2024-07-28","createdTime":"12:24:48"},{"jobId":"19","jobName":"Slitting - Scoring","status":"Pending","createdDate":"2024-07-28","createdTime":"12:24:48"},{"jobId":"20","jobName":"","status":"Pending","createdDate":"2024-07-28","createdTime":"12:24:48"}]}]},{"productId":"2","orderType":"Box","boxType":"RSC","deckle":"22.00","cutting":"45.50","productName":"no 2outer","ply":"3","topPaper":"180 gsm","paper":"100 gsm","flute":"100 gsm","l":"11","b":"11","h":"11","productionCutting":"45.5","productionDeckle":"44","joint":"","orderData":[]}]},{"partyId":"2","partyName":"abc","partyPhone":"7990695771","productData":[{"productId":"3","orderType":"Sheet","boxType":"","deckle":"38","cutting":"38","productName":"box","ply":"3","topPaper":"100 gsm","paper":"100 gsm","flute":"100 gsm","l":"","b":"","h":"","productionCutting":"76","productionDeckle":"38","joint":"","orderData":[]}]},{"partyId":"3","partyName":"applied auto","partyPhone":"7908190007","productData":[{"productId":"4","orderType":"Box","boxType":"Die Punch","deckle":"20","cutting":"30","productName":"no 5 inner","ply":"3","topPaper":"180 gsm","paper":"100 gsm","flute":"100 gsm","l":"","b":"","h":"","productionCutting":"30","productionDeckle":"40","joint":"","orderData":[]},{"productId":"6","orderType":"Roll","boxType":"","deckle":"12","cutting":"","productName":"8 roll","ply":"","topPaper":"","paper":"150 gsm","flute":"150 gsm","l":"","b":"","h":"","productionCutting":"","productionDeckle":"48","joint":"","orderData":[]},{"productId":"8","orderType":"Box","boxType":"RSC","deckle":"20.00","cutting":"41.50","productName":"no 3 box","ply":"5","topPaper":"100 gsm","paper":"100 gsm","flute":"100 gsm","l":"10","b":"10","h":"10","productionCutting":"41.5","productionDeckle":"40","joint":"","orderData":[{"orderId":"10","orderQuantity":"200","productionQuantity":"100","status":"In Progress","createdDate":"2024-07-03","createdTime":"16:12:24","jobData":[{"jobId":"1","jobName":"Corrugation","status":"Completed","createdDate":"2024-07-25","createdTime":"11:04:02"},{"jobId":"2","jobName":"Paper Cutting","status":"Pending","createdDate":"2024-07-25","createdTime":"11:04:02"},{"jobId":"3","jobName":"Pesting","status":"Pending","createdDate":"2024-07-25","createdTime":"11:04:02"},{"jobId":"4","jobName":"Slitting - Scoring","status":"Pending","createdDate":"2024-07-25","createdTime":"11:04:02"},{"jobId":"5","jobName":"Pin Joint","status":"Pending","createdDate":"2024-07-25","createdTime":"11:04:02"},{"jobId":"6","jobName":"Corrugation","status":"Pending","createdDate":"2024-07-27","createdTime":"12:41:20"},{"jobId":"7","jobName":"Paper Cutting","status":"Pending","createdDate":"2024-07-27","createdTime":"12:41:20"},{"jobId":"8","jobName":"Pesting","status":"Pending","createdDate":"2024-07-27","createdTime":"12:41:20"},{"jobId":"9","jobName":"Slitting - Scoring","status":"Pending","createdDate":"2024-07-27","createdTime":"12:41:20"},{"jobId":"10","jobName":"","status":"Pending","createdDate":"2024-07-27","createdTime":"12:41:20"}]}]}]},{"partyId":"4","partyName":"global cnc","partyPhone":"6434518154","productData":[{"productId":"5","orderType":"Roll","boxType":"","deckle":"36","cutting":"","productName":"36","ply":"","topPaper":"","paper":"100 gsm","flute":"100 gsm","l":"","b":"","h":"","productionCutting":"","productionDeckle":"36","joint":"","orderData":[]}]},{"partyId":"5","partyName":"vrudhi","partyPhone":"7894561237","productData":[{"productId":"7","orderType":"Sheet","boxType":"","deckle":"42","cutting":"42","productName":"42x42","ply":"2","topPaper":"","paper":"100 gsm","flute":"100 gsm","l":"","b":"","h":"","productionCutting":"42","productionDeckle":"42","joint":"","orderData":[]},{"productId":"9","orderType":"Box","boxType":"RSC","deckle":"61.00","cutting":"71.50","productName":"Box Joint","ply":"3","topPaper":"180 gsm","paper":"100 gsm","flute":"230 gsm","l":"10","b":"25","h":"36","productionCutting":"75","productionDeckle":"65","joint":"Glue Joint","orderData":[]},{"productId":"10","orderType":"Box","boxType":"Die Punch","deckle":"52","cutting":"63","productName":"Jox Boint","ply":"2","topPaper":"","paper":"180 gsm","flute":"Plastic","l":"","b":"","h":"","productionCutting":"80","productionDeckle":"60","joint":"","orderData":[]}]}]

GetJobModel getJobModelFromJson(String str) => GetJobModel.fromJson(json.decode(str));

String getJobModelToJson(GetJobModel data) => json.encode(data.toJson());

class GetJobModel {
  GetJobModel({
    String? code,
    String? msg,
    List<Data>? data,
  }) {
    _code = code;
    _msg = msg;
    _data = data;
  }

  GetJobModel.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    if (json['Data'] != null) {
      _data = [];
      json['Data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }

  String? _code;
  String? _msg;
  List<Data>? _data;

  GetJobModel copyWith({
    String? code,
    String? msg,
    List<Data>? data,
  }) =>
      GetJobModel(
        code: code ?? _code,
        msg: msg ?? _msg,
        data: data ?? _data,
      );

  String? get code => _code;

  String? get msg => _msg;

  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['msg'] = _msg;
    if (_data != null) {
      map['Data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// partyId : "1"
/// partyName : "delicate foods"
/// partyPhone : "9638879056"
/// productData : [{"productId":"1","orderType":"Box","boxType":"RSC","deckle":"24.00","cutting":"49.50","productName":"no 1 outer","ply":"5","topPaper":"180 gsm","paper":"100 gsm","flute":"100 gsm","l":"12","b":"12","h":"12","productionCutting":"49.5","productionDeckle":"48","joint":"","orderData":[{"orderId":"1","orderQuantity":"500","productionQuantity":"250","status":"In Progress","createdDate":"2024-07-03","createdTime":"15:31:29","jobData":[{"jobId":"11","jobName":"Corrugation","status":"Pending","createdDate":"2024-07-28","createdTime":"12:24:07"},{"jobId":"12","jobName":"Paper Cutting","status":"Pending","createdDate":"2024-07-28","createdTime":"12:24:07"},{"jobId":"13","jobName":"Pesting","status":"Pending","createdDate":"2024-07-28","createdTime":"12:24:07"},{"jobId":"14","jobName":"Slitting - Scoring","status":"Pending","createdDate":"2024-07-28","createdTime":"12:24:07"},{"jobId":"15","jobName":"","status":"Pending","createdDate":"2024-07-28","createdTime":"12:24:07"},{"jobId":"16","jobName":"Corrugation","status":"Pending","createdDate":"2024-07-28","createdTime":"12:24:48"},{"jobId":"17","jobName":"Paper Cutting","status":"Pending","createdDate":"2024-07-28","createdTime":"12:24:48"},{"jobId":"18","jobName":"Pesting","status":"Pending","createdDate":"2024-07-28","createdTime":"12:24:48"},{"jobId":"19","jobName":"Slitting - Scoring","status":"Pending","createdDate":"2024-07-28","createdTime":"12:24:48"},{"jobId":"20","jobName":"","status":"Pending","createdDate":"2024-07-28","createdTime":"12:24:48"}]}]},{"productId":"2","orderType":"Box","boxType":"RSC","deckle":"22.00","cutting":"45.50","productName":"no 2outer","ply":"3","topPaper":"180 gsm","paper":"100 gsm","flute":"100 gsm","l":"11","b":"11","h":"11","productionCutting":"45.5","productionDeckle":"44","joint":"","orderData":[]}]

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    String? partyId,
    String? partyName,
    String? partyPhone,
    List<ProductData>? productData,
  }) {
    _partyId = partyId;
    _partyName = partyName;
    _partyPhone = partyPhone;
    _productData = productData;
  }

  Data.fromJson(dynamic json) {
    _partyId = json['partyId'];
    _partyName = json['partyName'];
    _partyPhone = json['partyPhone'];
    if (json['productData'] != null) {
      _productData = [];
      json['productData'].forEach((v) {
        _productData?.add(ProductData.fromJson(v));
      });
    }
  }

  String? _partyId;
  String? _partyName;
  String? _partyPhone;
  List<ProductData>? _productData;

  Data copyWith({
    String? partyId,
    String? partyName,
    String? partyPhone,
    List<ProductData>? productData,
  }) =>
      Data(
        partyId: partyId ?? _partyId,
        partyName: partyName ?? _partyName,
        partyPhone: partyPhone ?? _partyPhone,
        productData: productData ?? _productData,
      );

  String? get partyId => _partyId;

  String? get partyName => _partyName;

  String? get partyPhone => _partyPhone;

  List<ProductData>? get productData => _productData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['partyId'] = _partyId;
    map['partyName'] = _partyName;
    map['partyPhone'] = _partyPhone;
    if (_productData != null) {
      map['productData'] = _productData?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// productId : "1"
/// orderType : "Box"
/// boxType : "RSC"
/// deckle : "24.00"
/// cutting : "49.50"
/// productName : "no 1 outer"
/// ply : "5"
/// topPaper : "180 gsm"
/// paper : "100 gsm"
/// flute : "100 gsm"
/// l : "12"
/// b : "12"
/// h : "12"
/// productionCutting : "49.5"
/// productionDeckle : "48"
/// joint : ""
/// orderData : [{"orderId":"1","orderQuantity":"500","productionQuantity":"250","status":"In Progress","createdDate":"2024-07-03","createdTime":"15:31:29","jobData":[{"jobId":"11","jobName":"Corrugation","status":"Pending","createdDate":"2024-07-28","createdTime":"12:24:07"},{"jobId":"12","jobName":"Paper Cutting","status":"Pending","createdDate":"2024-07-28","createdTime":"12:24:07"},{"jobId":"13","jobName":"Pesting","status":"Pending","createdDate":"2024-07-28","createdTime":"12:24:07"},{"jobId":"14","jobName":"Slitting - Scoring","status":"Pending","createdDate":"2024-07-28","createdTime":"12:24:07"},{"jobId":"15","jobName":"","status":"Pending","createdDate":"2024-07-28","createdTime":"12:24:07"},{"jobId":"16","jobName":"Corrugation","status":"Pending","createdDate":"2024-07-28","createdTime":"12:24:48"},{"jobId":"17","jobName":"Paper Cutting","status":"Pending","createdDate":"2024-07-28","createdTime":"12:24:48"},{"jobId":"18","jobName":"Pesting","status":"Pending","createdDate":"2024-07-28","createdTime":"12:24:48"},{"jobId":"19","jobName":"Slitting - Scoring","status":"Pending","createdDate":"2024-07-28","createdTime":"12:24:48"},{"jobId":"20","jobName":"","status":"Pending","createdDate":"2024-07-28","createdTime":"12:24:48"}]}]

ProductData productDataFromJson(String str) => ProductData.fromJson(json.decode(str));

String productDataToJson(ProductData data) => json.encode(data.toJson());

class ProductData {
  ProductData({
    String? productId,
    String? orderType,
    String? boxType,
    String? deckle,
    String? cutting,
    String? productName,
    String? ply,
    String? topPaper,
    String? paper,
    String? flute,
    String? l,
    String? b,
    String? h,
    String? productionCutting,
    String? productionDeckle,
    String? joint,
    String? ups,
    List<OrderData>? orderData,
  }) {
    _productId = productId;
    _orderType = orderType;
    _boxType = boxType;
    _deckle = deckle;
    _cutting = cutting;
    _productName = productName;
    _ply = ply;
    _topPaper = topPaper;
    _paper = paper;
    _flute = flute;
    _l = l;
    _b = b;
    _h = h;
    _productionCutting = productionCutting;
    _productionDeckle = productionDeckle;
    _joint = joint;
    _ups = ups;
    _orderData = orderData;
  }

  ProductData.fromJson(dynamic json) {
    _productId = json['productId'];
    _orderType = json['orderType'];
    _boxType = json['boxType'];
    _deckle = json['deckle'];
    _cutting = json['cutting'];
    _productName = json['productName'];
    _ply = json['ply'];
    _topPaper = json['topPaper'];
    _paper = json['paper'];
    _flute = json['flute'];
    _l = json['l'];
    _b = json['b'];
    _h = json['h'];
    _productionCutting = json['productionCutting'];
    _productionDeckle = json['productionDeckle'];
    _joint = json['joint'];
    _ups = json['ups'];
    if (json['orderData'] != null) {
      _orderData = [];
      json['orderData'].forEach((v) {
        _orderData?.add(OrderData.fromJson(v));
      });
    }
  }

  String? _productId;
  String? _orderType;
  String? _boxType;
  String? _deckle;
  String? _cutting;
  String? _productName;
  String? _ply;
  String? _topPaper;
  String? _paper;
  String? _flute;
  String? _l;
  String? _b;
  String? _h;
  String? _productionCutting;
  String? _productionDeckle;
  String? _joint;
  String? _ups;
  List<OrderData>? _orderData;

  ProductData copyWith({
    String? productId,
    String? orderType,
    String? boxType,
    String? deckle,
    String? cutting,
    String? productName,
    String? ply,
    String? topPaper,
    String? paper,
    String? flute,
    String? l,
    String? b,
    String? h,
    String? productionCutting,
    String? productionDeckle,
    String? joint,
    String? ups,
    List<OrderData>? orderData,
  }) =>
      ProductData(
        productId: productId ?? _productId,
        orderType: orderType ?? _orderType,
        boxType: boxType ?? _boxType,
        deckle: deckle ?? _deckle,
        cutting: cutting ?? _cutting,
        productName: productName ?? _productName,
        ply: ply ?? _ply,
        topPaper: topPaper ?? _topPaper,
        paper: paper ?? _paper,
        flute: flute ?? _flute,
        l: l ?? _l,
        b: b ?? _b,
        h: h ?? _h,
        productionCutting: productionCutting ?? _productionCutting,
        productionDeckle: productionDeckle ?? _productionDeckle,
        joint: joint ?? _joint,
        ups: ups ?? _ups,
        orderData: orderData ?? _orderData,
      );

  String? get productId => _productId;

  String? get orderType => _orderType;

  String? get boxType => _boxType;

  String? get deckle => _deckle;

  String? get cutting => _cutting;

  String? get productName => _productName;

  String? get ply => _ply;

  String? get topPaper => _topPaper;

  String? get paper => _paper;

  String? get flute => _flute;

  String? get l => _l;

  String? get b => _b;

  String? get h => _h;

  String? get productionCutting => _productionCutting;

  String? get productionDeckle => _productionDeckle;

  String? get joint => _joint;

  String? get ups => _ups;

  List<OrderData>? get orderData => _orderData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productId'] = _productId;
    map['orderType'] = _orderType;
    map['boxType'] = _boxType;
    map['deckle'] = _deckle;
    map['cutting'] = _cutting;
    map['productName'] = _productName;
    map['ply'] = _ply;
    map['topPaper'] = _topPaper;
    map['paper'] = _paper;
    map['flute'] = _flute;
    map['l'] = _l;
    map['b'] = _b;
    map['h'] = _h;
    map['productionCutting'] = _productionCutting;
    map['productionDeckle'] = _productionDeckle;
    map['joint'] = _joint;
    map['ups'] = _ups;
    if (_orderData != null) {
      map['orderData'] = _orderData?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// orderId : "1"
/// orderQuantity : "500"
/// productionQuantity : "250"
/// status : "In Progress"
/// createdDate : "2024-07-03"
/// createdTime : "15:31:29"
/// jobData : [{"jobId":"11","jobName":"Corrugation","status":"Pending","createdDate":"2024-07-28","createdTime":"12:24:07"},{"jobId":"12","jobName":"Paper Cutting","status":"Pending","createdDate":"2024-07-28","createdTime":"12:24:07"},{"jobId":"13","jobName":"Pesting","status":"Pending","createdDate":"2024-07-28","createdTime":"12:24:07"},{"jobId":"14","jobName":"Slitting - Scoring","status":"Pending","createdDate":"2024-07-28","createdTime":"12:24:07"},{"jobId":"15","jobName":"","status":"Pending","createdDate":"2024-07-28","createdTime":"12:24:07"},{"jobId":"16","jobName":"Corrugation","status":"Pending","createdDate":"2024-07-28","createdTime":"12:24:48"},{"jobId":"17","jobName":"Paper Cutting","status":"Pending","createdDate":"2024-07-28","createdTime":"12:24:48"},{"jobId":"18","jobName":"Pesting","status":"Pending","createdDate":"2024-07-28","createdTime":"12:24:48"},{"jobId":"19","jobName":"Slitting - Scoring","status":"Pending","createdDate":"2024-07-28","createdTime":"12:24:48"},{"jobId":"20","jobName":"","status":"Pending","createdDate":"2024-07-28","createdTime":"12:24:48"}]

OrderData orderDataFromJson(String str) => OrderData.fromJson(json.decode(str));

String orderDataToJson(OrderData data) => json.encode(data.toJson());

class OrderData {
  OrderData({
    String? orderId,
    String? orderQuantity,
    String? productionQuantity,
    String? status,
    String? createdDate,
    String? createdTime,
    List<JobData>? jobData,
  }) {
    _orderId = orderId;
    _orderQuantity = orderQuantity;
    _productionQuantity = productionQuantity;
    _status = status;
    _createdDate = createdDate;
    _createdTime = createdTime;
    _jobData = jobData;
  }

  OrderData.fromJson(dynamic json) {
    _orderId = json['orderId'];
    _orderQuantity = json['orderQuantity'];
    _productionQuantity = json['productionQuantity'];
    _status = json['status'];
    _createdDate = json['createdDate'];
    _createdTime = json['createdTime'];
    if (json['jobData'] != null) {
      _jobData = [];
      json['jobData'].forEach((v) {
        _jobData?.add(JobData.fromJson(v));
      });
    }
  }

  String? _orderId;
  String? _orderQuantity;
  String? _productionQuantity;
  String? _status;
  String? _createdDate;
  String? _createdTime;
  List<JobData>? _jobData;

  OrderData copyWith({
    String? orderId,
    String? orderQuantity,
    String? productionQuantity,
    String? status,
    String? createdDate,
    String? createdTime,
    List<JobData>? jobData,
  }) =>
      OrderData(
        orderId: orderId ?? _orderId,
        orderQuantity: orderQuantity ?? _orderQuantity,
        productionQuantity: productionQuantity ?? _productionQuantity,
        status: status ?? _status,
        createdDate: createdDate ?? _createdDate,
        createdTime: createdTime ?? _createdTime,
        jobData: jobData ?? _jobData,
      );

  String? get orderId => _orderId;

  String? get orderQuantity => _orderQuantity;

  String? get productionQuantity => _productionQuantity;

  String? get status => _status;

  String? get createdDate => _createdDate;

  String? get createdTime => _createdTime;

  List<JobData>? get jobData => _jobData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['orderId'] = _orderId;
    map['orderQuantity'] = _orderQuantity;
    map['productionQuantity'] = _productionQuantity;
    map['status'] = _status;
    map['createdDate'] = _createdDate;
    map['createdTime'] = _createdTime;
    if (_jobData != null) {
      map['jobData'] = _jobData?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// jobId : "11"
/// jobName : "Corrugation"
/// status : "Pending"
/// createdDate : "2024-07-28"
/// createdTime : "12:24:07"

JobData jobDataFromJson(String str) => JobData.fromJson(json.decode(str));

String jobDataToJson(JobData data) => json.encode(data.toJson());

class JobData {
  JobData({
    String? jobId,
    String? jobName,
    String? status,
    String? createdDate,
    String? createdTime,
  }) {
    _jobId = jobId;
    _jobName = jobName;
    _status = status;
    _createdDate = createdDate;
    _createdTime = createdTime;
  }

  JobData.fromJson(dynamic json) {
    _jobId = json['jobId'];
    _jobName = json['jobName'];
    _status = json['status'];
    _createdDate = json['createdDate'];
    _createdTime = json['createdTime'];
  }

  String? _jobId;
  String? _jobName;
  String? _status;
  String? _createdDate;
  String? _createdTime;

  JobData copyWith({
    String? jobId,
    String? jobName,
    String? status,
    String? createdDate,
    String? createdTime,
  }) =>
      JobData(
        jobId: jobId ?? _jobId,
        jobName: jobName ?? _jobName,
        status: status ?? _status,
        createdDate: createdDate ?? _createdDate,
        createdTime: createdTime ?? _createdTime,
      );

  String? get jobId => _jobId;

  String? get jobName => _jobName;

  String? get status => _status;

  String? get createdDate => _createdDate;

  String? get createdTime => _createdTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['jobId'] = _jobId;
    map['jobName'] = _jobName;
    map['status'] = _status;
    map['createdDate'] = _createdDate;
    map['createdTime'] = _createdTime;
    return map;
  }
}
