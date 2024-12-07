import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:raj_packaging/Constants/app_constance.dart';
import 'package:raj_packaging/Constants/get_storage.dart';
import 'package:raj_packaging/Network/models/jobs_models/get_job_model.dart' as get_jobs;
import 'package:raj_packaging/Network/services/in_job_services/in_job_service.dart';

part 'in_job_event.dart';

part 'in_job_state.dart';

class InJobBloc extends Bloc<InJobEvent, InJobState> {
  List<get_jobs.Data> ordersList = <get_jobs.Data>[];
  List<get_jobs.Data> searchedOrdersList = <get_jobs.Data>[];

  List<Map<String, int>> activeStepList = [];

  InJobBloc() : super(InJobInitial()) {
    on<InJobStartedEvent>((event, emit) {
      add(const InJobGetJobsEvent());
    });

    on<InJobGetJobsEvent>((event, emit) async {
      await getJobsApiCall(event, emit);
    });

    on<InJobGetJobsLoadingEvent>((event, emit) async {
      emit(InJobGetJobsLoadingState(isLoading: event.isLoading));
    });

    on<InJobGetJobsSuccessEvent>((event, emit) async {
      emit(InJobGetJobsSuccessState(partyList: event.ordersList, successMessage: event.successMessage));
    });

    on<InJobGetJobsFailedEvent>((event, emit) async {
      emit(InJobGetJobsFailedState());
    });

    on<InJobSearchOrderEvent>((event, emit) {
      emit(InJobSearchOrderState(ordersList: event.ordersList));
    });

    on<InJobDeleteOrderClickEvent>((event, emit) async {
      await checkDeleteJobs(event, emit);
    });

    on<InJobDeleteOrderLoadingEvent>((event, emit) async {
      emit(InJobDeleteOrderLoadingState(isLoading: event.isLoading));
    });

    on<InJobDeleteOrderSuccessEvent>((event, emit) async {
      emit(InJobDeleteOrderSuccessState(successMessage: event.successMessage));
    });

    on<InJobDeleteOrderFailedEvent>((event, emit) async {
      emit(InJobDeleteOrderFailedState(failedMessage: event.failedMessage));
    });
  }

  Future<void> getJobsApiCall(InJobGetJobsEvent event, Emitter<InJobState> emit) async {
    try {
      add(InJobGetJobsLoadingEvent(isLoading: event.isLoading));
      final response = await InJobService.getJobsService();

      if (response.isSuccess) {
        get_jobs.GetJobModel getJobModel = get_jobs.GetJobModel.fromJson(response.response?.data);
        setData(AppConstance.localJobsStored, getJobModel.toJson());
        dataAssignToList(getJobModel: getJobModel);
        add(InJobGetJobsSuccessEvent(ordersList: getJobModel.data ?? [], successMessage: response.message));
      } else {
        get_jobs.GetJobModel getJobModel = get_jobs.GetJobModel.fromJson(getData(AppConstance.localJobsStored));
        dataAssignToList(getJobModel: getJobModel);
        add(InJobGetJobsFailedEvent());
      }
    } finally {
      add(const InJobGetJobsLoadingEvent(isLoading: false));
    }
  }

  Future<void> dataAssignToList({required get_jobs.GetJobModel getJobModel}) async {
    ordersList.clear();
    searchedOrdersList.clear();
    activeStepList.clear();
    ordersList.addAll(getJobModel.data ?? []);
    searchedOrdersList.addAll(getJobModel.data ?? []);
    if (getJobModel.data != null) {
      for (int i = 0; i < getJobModel.data!.length; i++) {
        if (getJobModel.data?[i].productData != null) {
          for (int j = 0; j < getJobModel.data![i].productData!.length; j++) {
            if (getJobModel.data?[i].productData?[j].orderData != null) {
              for (int k = 0; k < getJobModel.data![i].productData![j].orderData!.length; k++) {
                if (getJobModel.data?[i].productData?[j].orderData?[k] != null) {
                  for (int l = 0; l < getJobModel.data![i].productData![j].orderData![k].jobData!.length; l++) {
                    if (getJobModel.data![i].productData![j].orderData![k].jobData![l].status == "Pending") {
                      activeStepList.add(
                        {
                          getJobModel.data![i].productData![j].orderData![k].orderId!: l,
                        },
                      );
                      break;
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  Future<void> searchPartyName(String searchedValue) async {
    searchedOrdersList.clear();
    if (searchedValue.isNotEmpty) {
      searchedOrdersList.addAll(ordersList.where((element) => element.partyName?.toLowerCase().contains(searchedValue.toLowerCase()) == true));
    } else {
      searchedOrdersList.addAll(ordersList);
    }
    add(InJobSearchOrderEvent(ordersList: searchedOrdersList));
  }

  Future<void> checkDeleteJobs(InJobDeleteOrderClickEvent event, Emitter<InJobState> emit) async {
    try {
      add(const InJobDeleteOrderLoadingEvent(isLoading: true));
      final response = await InJobService.deleteJobsService(orderId: event.orderId);

      if (response.isSuccess) {
        add(InJobDeleteOrderSuccessEvent(successMessage: response.message));
      } else {
        add(InJobDeleteOrderFailedEvent(failedMessage: response.message));
      }
    } finally {
      add(const InJobDeleteOrderLoadingEvent(isLoading: false));
    }
  }
}
