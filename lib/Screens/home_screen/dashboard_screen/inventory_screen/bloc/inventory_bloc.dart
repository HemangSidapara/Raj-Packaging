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
}
