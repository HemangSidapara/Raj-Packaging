import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:raj_packaging/Network/models/orders_models/get_orders_model.dart' as get_orders;
import 'package:raj_packaging/Network/services/create_order_services/create_order_service.dart';

part 'pending_orders_event.dart';
part 'pending_orders_state.dart';

class PendingOrdersBloc extends Bloc<PendingOrdersEvent, PendingOrdersState> {
  List<get_orders.Data> ordersList = <get_orders.Data>[];
  List<get_orders.Data> searchedOrdersList = <get_orders.Data>[];

  PendingOrdersBloc() : super(PendingOrdersInitial()) {
    on<PendingOrdersStartedEvent>((event, emit) {
      add(PendingOrdersGetOrdersEvent());
    });

    on<PendingOrdersGetOrdersEvent>((event, emit) async {
      await getOrdersApiCall(event, emit);
    });

    on<PendingOrdersGetOrdersLoadingEvent>((event, emit) async {
      emit(PendingOrdersGetOrdersLoadingState(isLoading: event.isLoading));
    });

    on<PendingOrdersGetOrdersSuccessEvent>((event, emit) async {
      emit(PendingOrdersGetOrdersSuccessState(partyList: event.ordersList, successMessage: event.successMessage));
    });

    on<PendingOrdersGetOrdersFailedEvent>((event, emit) async {
      emit(PendingOrdersGetOrdersFailedState());
    });

    on<PendingOrdersSearchOrderEvent>((event, emit) {
      emit(PendingOrdersSearchOrderState(ordersList: event.ordersList));
    });
  }

  Future<void> getOrdersApiCall(PendingOrdersGetOrdersEvent event, Emitter<PendingOrdersState> emit) async {
    try {
      add(const PendingOrdersGetOrdersLoadingEvent(isLoading: true));
      final response = await CreateOrderService.getPartiesService();

      if (response.isSuccess) {
        get_orders.GetOrdersModel getOrdersModel = get_orders.GetOrdersModel.fromJson(response.response?.data);
        ordersList.clear();
        searchedOrdersList.clear();
        ordersList.addAll(getOrdersModel.data ?? []);
        searchedOrdersList.addAll(getOrdersModel.data ?? []);
        add(PendingOrdersGetOrdersSuccessEvent(ordersList: getOrdersModel.data ?? [], successMessage: response.message));
      } else {
        add(PendingOrdersGetOrdersFailedEvent());
      }
    } finally {
      add(const PendingOrdersGetOrdersLoadingEvent(isLoading: false));
    }
  }

  Future<void> searchPartyName(String searchedValue) async {
    searchedOrdersList.clear();
    if (searchedValue.isNotEmpty) {
      searchedOrdersList.addAll(ordersList.where((element) => element.partyName?.toLowerCase().contains(searchedValue.toLowerCase()) == true));
    } else {
      searchedOrdersList.addAll(ordersList);
    }
    add(PendingOrdersSearchOrderEvent(ordersList: searchedOrdersList));
  }
}
