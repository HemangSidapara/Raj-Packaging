import 'dart:convert';

/// code : "200"
/// msg : "get Orders Successfully"
/// Data : [{"partyId":"1","partyName":"ABCD","partyPhone":"1212121212","productData":[{"productId":"1","orderType":"Sheet","boxType":"","deckle":"10","cutting":"10","productName":"Test","ply":"","topPaper":"","paper":"10","flute":"10","l":"","b":"","h":"","productionCutting":"10","productionDeckle":"10","orderData":[{"orderId":"1","orderQuantity":"10","productionQuantity":"10","createdDate":"2024-06-18","createdTime":"18:51:23"}]},{"productId":"2","orderType":"Sheet","boxType":"","deckle":"10","cutting":"10","productName":"Test","ply":"","topPaper":"","paper":"10","flute":"10","l":"","b":"","h":"","productionCutting":"10","productionDeckle":"10","orderData":[{"orderId":"2","orderQuantity":"10","productionQuantity":"10","createdDate":"2024-06-18","createdTime":"18:51:58"},{"orderId":"3","orderQuantity":"10","productionQuantity":"10","createdDate":"2024-06-18","createdTime":"18:52:13"}]}]}]

GetOrdersModel getOrdersModelFromJson(String str) => GetOrdersModel.fromJson(json.decode(str));
String getOrdersModelToJson(GetOrdersModel data) => json.encode(data.toJson());

class GetOrdersModel {
  GetOrdersModel({
    String? code,
    String? msg,
    List<Data>? data,
  }) {
    _code = code;
    _msg = msg;
    _data = data;
  }

  GetOrdersModel.fromJson(dynamic json) {
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
  GetOrdersModel copyWith({
    String? code,
    String? msg,
    List<Data>? data,
  }) =>
      GetOrdersModel(
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
/// partyName : "ABCD"
/// partyPhone : "1212121212"
/// productData : [{"productId":"1","orderType":"Sheet","boxType":"","deckle":"10","cutting":"10","productName":"Test","ply":"","topPaper":"","paper":"10","flute":"10","l":"","b":"","h":"","productionCutting":"10","productionDeckle":"10","orderData":[{"orderId":"1","orderQuantity":"10","productionQuantity":"10","createdDate":"2024-06-18","createdTime":"18:51:23"}]},{"productId":"2","orderType":"Sheet","boxType":"","deckle":"10","cutting":"10","productName":"Test","ply":"","topPaper":"","paper":"10","flute":"10","l":"","b":"","h":"","productionCutting":"10","productionDeckle":"10","orderData":[{"orderId":"2","orderQuantity":"10","productionQuantity":"10","createdDate":"2024-06-18","createdTime":"18:51:58"},{"orderId":"3","orderQuantity":"10","productionQuantity":"10","createdDate":"2024-06-18","createdTime":"18:52:13"}]}]

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
/// orderType : "Sheet"
/// boxType : ""
/// deckle : "10"
/// cutting : "10"
/// productName : "Test"
/// ply : ""
/// topPaper : ""
/// paper : "10"
/// flute : "10"
/// l : ""
/// b : ""
/// h : ""
/// productionCutting : "10"
/// productionDeckle : "10"
/// orderData : [{"orderId":"1","orderQuantity":"10","productionQuantity":"10","createdDate":"2024-06-18","createdTime":"18:51:23"}]

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
    if (_orderData != null) {
      map['orderData'] = _orderData?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// orderId : "1"
/// orderQuantity : "10"
/// productionQuantity : "10"
/// createdDate : "2024-06-18"
/// createdTime : "18:51:23"

OrderData orderDataFromJson(String str) => OrderData.fromJson(json.decode(str));
String orderDataToJson(OrderData data) => json.encode(data.toJson());

class OrderData {
  OrderData({
    String? orderId,
    String? orderQuantity,
    String? productionQuantity,
    String? createdDate,
    String? createdTime,
  }) {
    _orderId = orderId;
    _orderQuantity = orderQuantity;
    _productionQuantity = productionQuantity;
    _createdDate = createdDate;
    _createdTime = createdTime;
  }

  OrderData.fromJson(dynamic json) {
    _orderId = json['orderId'];
    _orderQuantity = json['orderQuantity'];
    _productionQuantity = json['productionQuantity'];
    _createdDate = json['createdDate'];
    _createdTime = json['createdTime'];
  }
  String? _orderId;
  String? _orderQuantity;
  String? _productionQuantity;
  String? _createdDate;
  String? _createdTime;
  OrderData copyWith({
    String? orderId,
    String? orderQuantity,
    String? productionQuantity,
    String? createdDate,
    String? createdTime,
  }) =>
      OrderData(
        orderId: orderId ?? _orderId,
        orderQuantity: orderQuantity ?? _orderQuantity,
        productionQuantity: productionQuantity ?? _productionQuantity,
        createdDate: createdDate ?? _createdDate,
        createdTime: createdTime ?? _createdTime,
      );
  String? get orderId => _orderId;
  String? get orderQuantity => _orderQuantity;
  String? get productionQuantity => _productionQuantity;
  String? get createdDate => _createdDate;
  String? get createdTime => _createdTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['orderId'] = _orderId;
    map['orderQuantity'] = _orderQuantity;
    map['productionQuantity'] = _productionQuantity;
    map['createdDate'] = _createdDate;
    map['createdTime'] = _createdTime;
    return map;
  }
}
