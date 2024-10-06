import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:raj_packaging/Constants/app_constance.dart';
import 'package:raj_packaging/Constants/get_storage.dart';
import 'package:raj_packaging/Network/models/completed_models/get_completed_orders_model.dart' as get_completed;
import 'package:raj_packaging/Network/services/completed_order_services/completed_order_service.dart';
import 'package:raj_packaging/generated/l10n.dart';

part 'completed_event.dart';
part 'completed_state.dart';

class CompletedBloc extends Bloc<CompletedEvent, CompletedState> {
  List<get_completed.Data> ordersList = <get_completed.Data>[];
  List<get_completed.Data> searchedOrdersList = <get_completed.Data>[];

  CompletedBloc() : super(CompletedInitial()) {
    on<CompletedStartedEvent>((event, emit) {
      add(CompletedGetOrdersEvent());
    });

    on<CompletedGetOrdersEvent>((event, emit) async {
      await getCompletedOrdersApiCall(event, emit);
    });

    on<CompletedGetOrdersLoadingEvent>((event, emit) async {
      emit(CompletedGetOrdersLoadingState(isLoading: event.isLoading));
    });

    on<CompletedGetOrdersSuccessEvent>((event, emit) async {
      emit(CompletedGetOrdersSuccessState(partyList: event.ordersList, successMessage: event.successMessage));
    });

    on<CompletedGetOrdersFailedEvent>((event, emit) async {
      emit(CompletedGetOrdersFailedState());
    });

    on<CompletedSearchOrderEvent>((event, emit) {
      emit(CompletedSearchOrderState(ordersList: event.ordersList));
    });

    on<CompletedEditQuantityClickEvent>((event, emit) async {
      await checkEditQuantity(event, emit);
    });

    on<CompletedEditQuantityLoadingEvent>((event, emit) async {
      emit(CompletedEditQuantityLoadingState(isLoading: event.isLoading));
    });

    on<CompletedEditQuantitySuccessEvent>((event, emit) async {
      emit(CompletedEditQuantitySuccessState(successMessage: event.successMessage));
    });

    on<CompletedEditQuantityFailedEvent>((event, emit) async {
      emit(CompletedEditQuantityFailedState(failedMessage: event.failedMessage));
    });

    on<CompletedArchiveOrderClickEvent>((event, emit) async {
      await checkArchiveOrder(event, emit);
    });

    on<CompletedArchiveOrderLoadingEvent>((event, emit) async {
      emit(CompletedArchiveOrderLoadingState(isLoading: event.isLoading));
    });

    on<CompletedArchiveOrderSuccessEvent>((event, emit) async {
      emit(CompletedArchiveOrderSuccessState(successMessage: event.successMessage));
    });

    on<CompletedArchiveOrderFailedEvent>((event, emit) async {
      emit(CompletedArchiveOrderFailedState(failedMessage: event.failedMessage));
    });
  }

  String? validateOrderQuantity(String? value) {
    if (value == null || value.isEmpty) {
      return S.current.pleaseEnterQuantity;
    }
    return null;
  }

  Future<void> getCompletedOrdersApiCall(CompletedGetOrdersEvent event, Emitter<CompletedState> emit) async {
    try {
      add(const CompletedGetOrdersLoadingEvent(isLoading: true));
      final response = await CompletedOrderService.getCompletedOrderService();

      if (response.isSuccess) {
        get_completed.GetCompletedOrdersModel getOrdersModel = get_completed.GetCompletedOrdersModel.fromJson(response.response?.data);
        ordersList.clear();
        searchedOrdersList.clear();
        ordersList.addAll(getOrdersModel.data ?? []);
        searchedOrdersList.addAll(getOrdersModel.data ?? []);
        setData(AppConstance.localCompletedOrderStored, getOrdersModel.toJson());
        add(CompletedGetOrdersSuccessEvent(ordersList: getOrdersModel.data ?? [], successMessage: response.message));
      } else {
        get_completed.GetCompletedOrdersModel getOrdersModel = get_completed.GetCompletedOrdersModel.fromJson(getData(AppConstance.localCompletedOrderStored));
        ordersList.clear();
        searchedOrdersList.clear();
        ordersList.addAll(getOrdersModel.data ?? []);
        searchedOrdersList.addAll(getOrdersModel.data ?? []);
        add(CompletedGetOrdersFailedEvent());
      }
    } finally {
      add(const CompletedGetOrdersLoadingEvent(isLoading: false));
    }
  }

  Future<void> searchPartyName(String searchedValue) async {
    searchedOrdersList.clear();
    if (searchedValue.isNotEmpty) {
      searchedOrdersList.addAll(ordersList.where((element) => element.partyName?.toLowerCase().contains(searchedValue.toLowerCase()) == true));
    } else {
      searchedOrdersList.addAll(ordersList);
    }
    add(CompletedSearchOrderEvent(ordersList: searchedOrdersList));
  }

  Future<void> checkEditQuantity(CompletedEditQuantityClickEvent event, Emitter<CompletedState> emit) async {
    try {
      add(const CompletedEditQuantityLoadingEvent(isLoading: true));
      if (event.isValidate) {
        final response = await CompletedOrderService.editQuantityService(
          orderId: event.orderId,
          orderQuantity: event.orderQuantity,
        );

        if (response.isSuccess) {
          add(CompletedEditQuantitySuccessEvent(successMessage: response.message));
        } else {
          add(CompletedEditQuantityFailedEvent(failedMessage: response.message));
        }
      }
    } finally {
      add(const CompletedEditQuantityLoadingEvent(isLoading: false));
    }
  }

  Future<void> checkArchiveOrder(CompletedArchiveOrderClickEvent event, Emitter<CompletedState> emit) async {
    try {
      add(const CompletedArchiveOrderLoadingEvent(isLoading: true));
      final response = await CompletedOrderService.archiveOrderService(
        orderId: event.orderId,
      );

      if (response.isSuccess) {
        add(CompletedArchiveOrderSuccessEvent(successMessage: response.message));
      } else {
        add(CompletedArchiveOrderFailedEvent(failedMessage: response.message));
      }
    } finally {
      add(const CompletedArchiveOrderLoadingEvent(isLoading: false));
    }
  }
}
