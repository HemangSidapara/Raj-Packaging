import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:raj_packaging/Network/services/inventory_services/inventory_services.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  List inventoryList = [];

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
