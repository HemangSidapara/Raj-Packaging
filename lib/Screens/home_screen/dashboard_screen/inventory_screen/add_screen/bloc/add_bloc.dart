import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:raj_packaging/Constants/app_constance.dart';
import 'package:raj_packaging/Constants/get_storage.dart';
import 'package:raj_packaging/Network/models/inventory_models/get_inventory_model.dart' as get_inventory;
import 'package:raj_packaging/Network/services/inventory_services/inventory_services.dart';
import 'package:raj_packaging/generated/l10n.dart';

part 'add_event.dart';
part 'add_state.dart';

class AddBloc extends Bloc<AddEvent, AddState> {
  List<get_inventory.Data> inventoryList = [];
  int entryTypeIndex = 0;

  int itemsTypeIndex = 0;

  List<String> entryList = [
    "Add",
    "Consume",
  ];

  List<String> itemList = [
    "Reel",
    "Printing Plates",
    "Die",
    "Paper",
  ];

  List<String> sizeList = [];

  List<String> gsmList = [];

  List<String> bfList = [];

  List<String> shadeList = [];

  AddBloc() : super(AddInitial()) {
    on<AddStartedEvent>((event, emit) {
      add(const AddGetInventoryEvent());
    });

    on<AddGetInventoryEvent>((event, emit) async {
      await getProductionDataApiCall(event, emit);
    });

    on<AddGetInventoryLoadingEvent>((event, emit) async {
      emit(AddGetInventoryLoadingState(isLoading: event.isLoading));
    });

    on<AddGetInventorySuccessEvent>((event, emit) async {
      emit(AddGetInventorySuccessState(inventoryList: event.inventoryList, successMessage: event.successMessage));
    });

    on<AddGetInventoryFailedEvent>((event, emit) async {
      emit(AddGetInventoryFailedState());
    });

    on<AddTypeEvent>((event, emit) async {
      entryTypeIndex = event.entryTypeIndex;
      emit(AddTypeState(entryTypeIndex: event.entryTypeIndex));
    });

    on<AddItemsTypeEvent>((event, emit) async {
      itemsTypeIndex = event.itemsTypeIndex;
      emit(AddItemsTypeState(itemsTypeIndex: event.itemsTypeIndex));
    });

    on<AddButtonClickEvent>((event, emit) async {
      await checkEntry(event, emit);
    });

    on<AddLoadingEvent>((event, emit) async {
      emit(AddLoadingState(isLoading: event.isLoading));
    });

    on<AddSuccessEvent>((event, emit) async {
      emit(AddSuccessState(successMessage: event.successMessage));
    });

    on<AddFailedEvent>((event, emit) async {
      emit(AddFailedState());
    });
  }

  String? validateSize(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.pleaseSelectSize;
    }
    return null;
  }

  String? validateGSM(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.pleaseSelectGSM;
    }
    return null;
  }

  String? validateBF(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.pleaseSelectBF;
    }
    return null;
  }

  String? validateShade(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.pleaseSelectShade;
    }
    return null;
  }

  String? validateQuantity(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.pleaseEnterQuantity;
    }
    return null;
  }

  String? validateWeight(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.pleaseEnterWeight;
    } else if (num.tryParse(value) == null) {
      return S.current.pleaseEnterValidWeight;
    }
    return null;
  }

  Future<void> getProductionDataApiCall(AddGetInventoryEvent event, Emitter<AddState> emit) async {
    try {
      add(AddGetInventoryLoadingEvent(isLoading: event.isLoading));
      final response = await InventoryServices.getProductionService();

      if (response.isSuccess) {
        get_inventory.GetInventoryModel inventoryModel = get_inventory.GetInventoryModel.fromJson(response.response?.data);
        inventoryList.clear();
        inventoryList.addAll(inventoryModel.data ?? []);
        resetData();
        setData(AppConstance.localInventoryStored, inventoryModel.toJson());
        add(AddGetInventorySuccessEvent(inventoryList: inventoryList, successMessage: response.message));
      } else {
        get_inventory.GetInventoryModel inventoryModel = get_inventory.GetInventoryModel.fromJson(getData(AppConstance.localInventoryStored));
        inventoryList.clear();
        inventoryList.addAll(inventoryModel.data ?? []);
        resetData();
        add(AddGetInventoryFailedEvent(inventoryList: inventoryList));
      }
    } finally {
      add(const AddGetInventoryLoadingEvent(isLoading: false));
    }
  }

  resetData() {
    sizeList.clear();
    gsmList.clear();
    bfList.clear();
    shadeList.clear();
    for (int i = 0; i < inventoryList.length; i++) {
      if (inventoryList[i].size != null && inventoryList[i].size?.isNotEmpty == true && sizeList.every((element) => element.toString().toLowerCase() != inventoryList[i].size.toString().toLowerCase())) {
        sizeList.add(inventoryList[i].size!);
      }
      if (inventoryList[i].gsm != null && inventoryList[i].gsm?.isNotEmpty == true && gsmList.every((element) => element.toString().toLowerCase() != inventoryList[i].gsm.toString().toLowerCase())) {
        gsmList.add(inventoryList[i].gsm!);
      }
      if (inventoryList[i].bf != null && inventoryList[i].bf?.isNotEmpty == true && bfList.every((element) => element.toString().toLowerCase() != inventoryList[i].bf.toString().toLowerCase())) {
        bfList.add(inventoryList[i].bf!);
      }
      if (inventoryList[i].shade != null && inventoryList[i].shade?.isNotEmpty == true && shadeList.every((element) => element.toString().toLowerCase() != inventoryList[i].shade.toString().toLowerCase())) {
        shadeList.add(inventoryList[i].shade!);
      }
    }
  }

  Future<void> checkEntry(AddButtonClickEvent event, Emitter<AddState> emit) async {
    try {
      add(const AddLoadingEvent(isLoading: true));
      if (event.isValidate) {
        final response = await InventoryServices.createEntryService(
          entryType: event.entryType,
          itemType: event.itemType,
          size: event.size,
          gsm: event.gsm,
          bf: event.bf,
          shade: event.shade,
          weight: event.weight,
          quantity: event.quantity,
        );

        if (response.isSuccess) {
          add(AddSuccessEvent(successMessage: response.message));
        } else {
          add(AddFailedEvent());
        }
      }
    } finally {
      add(const AddLoadingEvent(isLoading: false));
    }
  }
}
