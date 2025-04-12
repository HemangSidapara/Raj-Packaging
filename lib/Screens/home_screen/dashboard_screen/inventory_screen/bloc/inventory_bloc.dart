import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:raj_packaging/Network/services/inventory_services/inventory_services.dart';
import 'package:raj_packaging/generated/l10n.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  List inventoryList = [];
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

  List<String> sizeList = [
    "1 x 1",
    "1.5 x 1.5",
    "2 x 2",
    "3 x 3",
    "4 x 4",
    "5 x 5",
  ];

  List<String> gsmList = [
    "100 gsm",
    "200 gsm",
    "300 gsm",
    "400 gsm",
    "500 gsm",
    "600 gsm",
    "700 gsm",
    "800 gsm",
    "900 gsm",
    "1000 gsm",
    "1100 gsm",
  ];

  List<String> bfList = [
    "BF 1",
    "BF 2",
    "BF 3",
    "BF 4",
    "BF 5",
    "BF 6",
    "BF 7",
    "BF 8",
    "BF 9",
    "BF 10",
  ];

  List<String> shadeList = [
    "Shade 1",
    "Shade 2",
    "Shade 3",
    "Shade 4",
    "Shade 5",
    "Shade 6",
    "Shade 7",
    "Shade 8",
    "Shade 9",
    "Shade 10",
  ];

  InventoryBloc() : super(InventoryInitial()) {
    on<InventoryStartedEvent>((event, emit) {
      add(const InventoryGetInventoryEvent());
    });

    on<InventoryGetInventoryEvent>((event, emit) async {
      await getProductionDataApiCall(event, emit);
    });

    on<InventoryGetInventoryLoadingEvent>((event, emit) async {
      emit(InventoryGetInventoryLoadingState(isLoading: event.isLoading));
    });

    on<InventoryGetInventorySuccessEvent>((event, emit) async {
      emit(InventoryGetInventorySuccessState(inventoryList: event.inventoryList, successMessage: event.successMessage));
    });

    on<InventoryGetInventoryFailedEvent>((event, emit) async {
      emit(InventoryGetInventoryFailedState());
    });

    on<InventoryEntryTypeEvent>((event, emit) async {
      entryTypeIndex = event.entryTypeIndex;
      emit(InventoryEntryTypeState(entryTypeIndex: event.entryTypeIndex));
    });

    on<InventoryItemsTypeEvent>((event, emit) async {
      itemsTypeIndex = event.itemsTypeIndex;
      emit(InventoryItemsTypeState(itemsTypeIndex: event.itemsTypeIndex));
    });

    on<InventoryEntryButtonClickEvent>((event, emit) async {
      await checkEntry(event, emit);
    });

    on<InventoryEntryLoadingEvent>((event, emit) async {
      emit(InventoryEntryLoadingState(isLoading: event.isLoading));
    });

    on<InventoryEntrySuccessEvent>((event, emit) async {
      emit(InventoryEntrySuccessState(successMessage: event.successMessage));
    });

    on<InventoryEntryFailedEvent>((event, emit) async {
      emit(InventoryEntryFailedState());
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

  Future<void> getProductionDataApiCall(InventoryGetInventoryEvent event, Emitter<InventoryState> emit) async {
    try {
      add(InventoryGetInventoryLoadingEvent(isLoading: event.isLoading));
      final response = await InventoryServices.getProductionService();

      if (response.isSuccess) {
        inventoryList.clear();
        inventoryList = (response.response?.data['Tabs'] as List<dynamic>).firstOrNull ?? {};
        add(InventoryGetInventorySuccessEvent(inventoryList: inventoryList, successMessage: response.message));
      }
    } finally {
      add(const InventoryGetInventoryLoadingEvent(isLoading: false));
    }
  }

  Future<void> checkEntry(InventoryEntryButtonClickEvent event, Emitter<InventoryState> emit) async {
    try {
      add(const InventoryEntryLoadingEvent(isLoading: true));
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
          add(InventoryEntrySuccessEvent(successMessage: response.message));
        } else {
          add(InventoryEntryFailedEvent());
        }
      }
    } finally {
      add(const InventoryEntryLoadingEvent(isLoading: false));
    }
  }
}
