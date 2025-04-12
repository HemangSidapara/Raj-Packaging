import 'dart:convert';

/// data : [{"entryType":"Add","itemType":"Reel","size":"10*10","gsm":"100","bf":"excellent","shade":"white","weight":"1000","quantity":"100"},{"entryType":"Add","itemType":"Reel","size":"10*10","gsm":"100","bf":"excellent","shade":"white","weight":"1000","quantity":"100"},{"entryType":"Add","itemType":"Reel","size":"10*10","gsm":"100","bf":"excellent","shade":"white","weight":"1000","quantity":"100"},{"entryType":"Add","itemType":"Reel","size":"10*10","gsm":"100","bf":"excellent","shade":"white","weight":"1000","quantity":"100"}]

GetInventoryModel getInventoryModelFromJson(String str) => GetInventoryModel.fromJson(json.decode(str));

String getInventoryModelToJson(GetInventoryModel data) => json.encode(data.toJson());

class GetInventoryModel {
  GetInventoryModel({
    List<Data>? data,
  }) {
    _data = data;
  }

  GetInventoryModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }

  List<Data>? _data;

  GetInventoryModel copyWith({
    List<Data>? data,
  }) =>
      GetInventoryModel(
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

/// entryType : "Add"
/// itemType : "Reel"
/// size : "10*10"
/// gsm : "100"
/// bf : "excellent"
/// shade : "white"
/// weight : "1000"
/// quantity : "100"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    String? entryType,
    String? itemType,
    String? size,
    String? gsm,
    String? bf,
    String? shade,
    String? weight,
    String? quantity,
    String? createdDate,
  }) {
    _entryType = entryType;
    _itemType = itemType;
    _size = size;
    _gsm = gsm;
    _bf = bf;
    _shade = shade;
    _weight = weight;
    _quantity = quantity;
    _createdDate = createdDate;
  }

  Data.fromJson(dynamic json) {
    _entryType = json['entryType'];
    _itemType = json['itemType'];
    _size = json['size'];
    _gsm = json['gsm'];
    _bf = json['bf'];
    _shade = json['shade'];
    _weight = json['weight'];
    _quantity = json['quantity'];
    _createdDate = json['createdDate'];
  }

  String? _entryType;
  String? _itemType;
  String? _size;
  String? _gsm;
  String? _bf;
  String? _shade;
  String? _weight;
  String? _quantity;
  String? _createdDate;

  Data copyWith({
    String? entryType,
    String? itemType,
    String? size,
    String? gsm,
    String? bf,
    String? shade,
    String? weight,
    String? quantity,
    String? createdDate,
  }) =>
      Data(
        entryType: entryType ?? _entryType,
        itemType: itemType ?? _itemType,
        size: size ?? _size,
        gsm: gsm ?? _gsm,
        bf: bf ?? _bf,
        shade: shade ?? _shade,
        weight: weight ?? _weight,
        quantity: quantity ?? _quantity,
        createdDate: createdDate ?? _createdDate,
      );

  String? get entryType => _entryType;

  String? get itemType => _itemType;

  String? get size => _size;

  String? get gsm => _gsm;

  String? get bf => _bf;

  String? get shade => _shade;

  String? get weight => _weight;

  String? get quantity => _quantity;

  String? get createdDate => _createdDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['entryType'] = _entryType;
    map['itemType'] = _itemType;
    map['size'] = _size;
    map['gsm'] = _gsm;
    map['bf'] = _bf;
    map['shade'] = _shade;
    map['weight'] = _weight;
    map['quantity'] = _quantity;
    map['createdDate'] = _createdDate;
    return map;
  }
}
