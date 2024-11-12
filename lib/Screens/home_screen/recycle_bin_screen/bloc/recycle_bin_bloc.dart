import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:raj_packaging/Constants/app_constance.dart';
import 'package:raj_packaging/Constants/get_storage.dart';
import 'package:raj_packaging/Network/models/recycle_bin_models/get_recycle_bin_model.dart' as get_recycle_bin;
import 'package:raj_packaging/Network/services/recycle_bin_services/recycle_bin_service.dart';
import 'package:raj_packaging/generated/l10n.dart';

part 'recycle_bin_event.dart';
part 'recycle_bin_state.dart';

class RecycleBinBloc extends Bloc<RecycleBinEvent, RecycleBinState> {
  List<get_recycle_bin.Data> ordersList = <get_recycle_bin.Data>[];
  List<get_recycle_bin.Data> searchedOrdersList = <get_recycle_bin.Data>[];

  RecycleBinBloc() : super(RecycleBinInitial()) {
    on<RecycleBinStartedEvent>((event, emit) {
      add(RecycleBinGetOrdersEvent());
    });

    on<RecycleBinGetOrdersEvent>((event, emit) async {
      await getRecycleBinOrdersApiCall(event, emit);
    });

    on<RecycleBinGetOrdersLoadingEvent>((event, emit) async {
      emit(RecycleBinGetOrdersLoadingState(isLoading: event.isLoading));
    });

    on<RecycleBinGetOrdersSuccessEvent>((event, emit) async {
      emit(RecycleBinGetOrdersSuccessState(partyList: event.ordersList, successMessage: event.successMessage));
    });

    on<RecycleBinGetOrdersFailedEvent>((event, emit) async {
      emit(RecycleBinGetOrdersFailedState());
    });

    on<RecycleBinSearchOrderEvent>((event, emit) {
      emit(RecycleBinSearchOrderState(ordersList: event.ordersList));
    });
  }

  String? validateOrderQuantity(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.pleaseEnterQuantity;
    }
    return null;
  }

  Future<void> getRecycleBinOrdersApiCall(RecycleBinGetOrdersEvent event, Emitter<RecycleBinState> emit) async {
    try {
      add(const RecycleBinGetOrdersLoadingEvent(isLoading: true));
      final response = await RecycleBinService.getRecycleBinOrderService();

      if (response.isSuccess) {
        get_recycle_bin.GetRecycleBinModel getOrdersModel = get_recycle_bin.GetRecycleBinModel.fromJson(response.response?.data);
        ordersList.clear();
        searchedOrdersList.clear();
        ordersList.addAll(getOrdersModel.data ?? []);
        searchedOrdersList.addAll(getOrdersModel.data ?? []);
        setData(AppConstance.localCompletedOrderStored, getOrdersModel.toJson());
        add(RecycleBinGetOrdersSuccessEvent(ordersList: getOrdersModel.data ?? [], successMessage: response.message));
      } else {
        get_recycle_bin.GetRecycleBinModel getOrdersModel = get_recycle_bin.GetRecycleBinModel.fromJson(getData(AppConstance.localCompletedOrderStored));
        ordersList.clear();
        searchedOrdersList.clear();
        ordersList.addAll(getOrdersModel.data ?? []);
        searchedOrdersList.addAll(getOrdersModel.data ?? []);
        add(RecycleBinGetOrdersFailedEvent());
      }
    } finally {
      add(const RecycleBinGetOrdersLoadingEvent(isLoading: false));
    }
  }

  Future<void> searchPartyName(String searchedValue) async {
    searchedOrdersList.clear();
    if (searchedValue.isNotEmpty) {
      searchedOrdersList.addAll(ordersList.where((element) => element.partyName?.toLowerCase().contains(searchedValue.toLowerCase()) == true));
    } else {
      searchedOrdersList.addAll(ordersList);
    }
    add(RecycleBinSearchOrderEvent(ordersList: searchedOrdersList));
  }
}
