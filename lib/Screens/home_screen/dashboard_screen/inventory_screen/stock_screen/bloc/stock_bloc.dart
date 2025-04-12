import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:raj_packaging/Constants/app_constance.dart';
import 'package:raj_packaging/Constants/get_storage.dart';
import 'package:raj_packaging/Network/models/inventory_models/get_inventory_model.dart' as get_inventory;
import 'package:raj_packaging/Network/services/inventory_services/inventory_services.dart';

part 'stock_event.dart';
part 'stock_state.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  List<get_inventory.Data> inventoryList = [];

  StockBloc() : super(StockInitial()) {
    on<StockStartedEvent>((event, emit) {
      add(const StockGetInventoryEvent());
    });

    on<StockGetInventoryEvent>((event, emit) async {
      await getProductionDataApiCall(event, emit);
    });

    on<StockGetInventoryLoadingEvent>((event, emit) async {
      emit(StockGetInventoryLoadingState(isLoading: event.isLoading));
    });

    on<StockGetInventorySuccessEvent>((event, emit) async {
      emit(StockGetInventorySuccessState(inventoryList: event.inventoryList, successMessage: event.successMessage));
    });

    on<StockGetInventoryFailedEvent>((event, emit) async {
      emit(StockGetInventoryFailedState());
    });
  }

  Future<void> getProductionDataApiCall(StockGetInventoryEvent event, Emitter<StockState> emit) async {
    try {
      add(StockGetInventoryLoadingEvent(isLoading: event.isLoading));
      final response = await InventoryServices.getProductionService();

      if (response.isSuccess) {
        get_inventory.GetInventoryModel inventoryModel = get_inventory.GetInventoryModel.fromJson(response.response?.data);
        inventoryList.clear();
        inventoryList.addAll(inventoryModel.data ?? []);
        setData(AppConstance.localInventoryStored, inventoryModel.toJson());
        add(StockGetInventorySuccessEvent(inventoryList: inventoryList, successMessage: response.message));
      } else {
        get_inventory.GetInventoryModel inventoryModel = get_inventory.GetInventoryModel.fromJson(getData(AppConstance.localInventoryStored));
        inventoryList.clear();
        inventoryList.addAll(inventoryModel.data ?? []);
        add(StockGetInventoryFailedEvent(inventoryList: inventoryList));
      }
    } finally {
      add(const StockGetInventoryLoadingEvent(isLoading: false));
    }
  }
}
