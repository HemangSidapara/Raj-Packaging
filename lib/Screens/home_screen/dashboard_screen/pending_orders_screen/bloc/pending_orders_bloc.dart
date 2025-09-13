import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:raj_packaging/Constants/app_constance.dart';
import 'package:raj_packaging/Constants/get_storage.dart';
import 'package:raj_packaging/Network/models/orders_models/get_orders_model.dart' as get_orders;
import 'package:raj_packaging/Network/services/create_order_services/create_order_service.dart';
import 'package:raj_packaging/Network/services/pending_orders_services/pending_orders_service.dart';
import 'package:raj_packaging/generated/l10n.dart';

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

    on<PendingOrdersEditPartyClickEvent>((event, emit) async {
      await checkEditParty(event, emit);
    });

    on<PendingOrdersEditPartyLoadingEvent>((event, emit) async {
      emit(PendingOrdersEditPartyLoadingState(isLoading: event.isLoading));
    });

    on<PendingOrdersEditPartySuccessEvent>((event, emit) async {
      emit(PendingOrdersEditPartySuccessState(successMessage: event.successMessage));
    });

    on<PendingOrdersEditPartyFailedEvent>((event, emit) async {
      emit(PendingOrdersEditPartyFailedState(failedMessage: event.failedMessage));
    });

    on<PendingOrdersCreateJobClickEvent>((event, emit) async {
      await checkCreateJob(event, emit);
    });

    on<PendingOrdersCreateJobLoadingEvent>((event, emit) async {
      emit(PendingOrdersCreateJobLoadingState(isLoading: event.isLoading));
    });

    on<PendingOrdersCreateJobSuccessEvent>((event, emit) async {
      emit(PendingOrdersCreateJobSuccessState(successMessage: event.successMessage));
    });

    on<PendingOrdersCreateJobFailedEvent>((event, emit) async {
      emit(PendingOrdersCreateJobFailedState(failedMessage: event.failedMessage));
    });

    on<PendingOrdersDeleteOrderClickEvent>((event, emit) async {
      await checkDeleteOrder(event, emit);
    });

    on<PendingOrdersDeleteOrderLoadingEvent>((event, emit) async {
      emit(PendingOrdersDeleteOrderLoadingState(isLoading: event.isLoading));
    });

    on<PendingOrdersDeleteOrderSuccessEvent>((event, emit) async {
      emit(PendingOrdersDeleteOrderSuccessState(successMessage: event.successMessage));
    });

    on<PendingOrdersDeleteOrderFailedEvent>((event, emit) async {
      emit(PendingOrdersDeleteOrderFailedState(failedMessage: event.failedMessage));
    });
  }

  String? validatePartyName(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.pleaseEnterPartyName;
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.pleaseEnterPhoneNumber;
    } else if (value.length < 10) {
      return S.current.pleaseEnterValidPhoneNumber;
    }
    return null;
  }

  Future<void> getOrdersApiCall(PendingOrdersGetOrdersEvent event, Emitter<PendingOrdersState> emit) async {
    try {
      add(const PendingOrdersGetOrdersLoadingEvent(isLoading: true));
      final response = await PendingOrdersService.getOrdersService();

      if (response.isSuccess) {
        get_orders.GetOrdersModel getOrdersModel = get_orders.GetOrdersModel.fromJson(response.response?.data);
        ordersList.clear();
        searchedOrdersList.clear();
        ordersList.addAll(getOrdersModel.data ?? []);
        searchedOrdersList.addAll(getOrdersModel.data ?? []);
        setData(AppConstance.localPendingOrdersStored, getOrdersModel.toJson());
        add(PendingOrdersGetOrdersSuccessEvent(ordersList: getOrdersModel.data ?? [], successMessage: response.message));
      } else {
        get_orders.GetOrdersModel getOrdersModel = get_orders.GetOrdersModel.fromJson(getData(AppConstance.localCompletedOrderStored));
        ordersList.clear();
        searchedOrdersList.clear();
        ordersList.addAll(getOrdersModel.data ?? []);
        searchedOrdersList.addAll(getOrdersModel.data ?? []);
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

  Future<void> checkEditParty(PendingOrdersEditPartyClickEvent event, Emitter<PendingOrdersState> emit) async {
    try {
      add(const PendingOrdersEditPartyLoadingEvent(isLoading: true));
      if (event.isValidate) {
        final response = await CreateOrderService.editPartyService(
          partyId: event.partyId,
          partyName: event.partyName,
          partyPhone: event.partyPhone,
        );

        if (response.isSuccess) {
          add(PendingOrdersEditPartySuccessEvent(successMessage: response.message));
        } else {
          add(PendingOrdersEditPartyFailedEvent(failedMessage: response.message));
        }
      }
    } finally {
      add(const PendingOrdersEditPartyLoadingEvent(isLoading: false));
    }
  }

  Future<void> checkCreateJob(PendingOrdersCreateJobClickEvent event, Emitter<PendingOrdersState> emit) async {
    try {
      add(const PendingOrdersCreateJobLoadingEvent(isLoading: true));
      final response = await PendingOrdersService.createJobService(
        partyId: event.partyId,
        productId: event.productId,
        orderId: event.orderId,
        branch: event.branch,
      );

      if (response.isSuccess) {
        add(PendingOrdersCreateJobSuccessEvent(successMessage: response.message));
      } else {
        add(PendingOrdersCreateJobFailedEvent(failedMessage: response.message));
      }
    } finally {
      add(const PendingOrdersCreateJobLoadingEvent(isLoading: false));
    }
  }

  Future<void> checkDeleteOrder(PendingOrdersDeleteOrderClickEvent event, Emitter<PendingOrdersState> emit) async {
    try {
      add(const PendingOrdersDeleteOrderLoadingEvent(isLoading: true));
      final response = await PendingOrdersService.deleteOrderService(orderId: event.orderId);

      if (response.isSuccess) {
        add(PendingOrdersDeleteOrderSuccessEvent(successMessage: response.message));
      } else {
        add(PendingOrdersDeleteOrderFailedEvent(failedMessage: response.message));
      }
    } finally {
      add(const PendingOrdersDeleteOrderLoadingEvent(isLoading: false));
    }
  }
}
