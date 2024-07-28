import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
      add(InJobGetJobsEvent());
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

    on<InJobCompleteJobClickEvent>((event, emit) async {
      await completeJobApiCall(event, emit);
    });

    on<InJobCompleteJobLoadingEvent>((event, emit) async {
      emit(InJobCompleteJobLoadingState(isLoading: event.isLoading));
    });

    on<InJobCompleteJobSuccessEvent>((event, emit) async {
      emit(InJobCompleteJobSuccessState(successMessage: event.successMessage));
    });

    on<InJobCompleteJobFailedEvent>((event, emit) async {
      emit(InJobCompleteJobFailedState(failedMessage: event.failedMessage));
    });
  }

  Future<void> getJobsApiCall(InJobGetJobsEvent event, Emitter<InJobState> emit) async {
    try {
      add(InJobGetJobsLoadingEvent(isLoading: event.isLoading));
      final response = await InJobService.getJobsService();

      if (response.isSuccess) {
        get_jobs.GetJobModel getJobModel = get_jobs.GetJobModel.fromJson(response.response?.data);
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
        add(InJobGetJobsSuccessEvent(ordersList: getJobModel.data ?? [], successMessage: response.message));
      } else {
        add(InJobGetJobsFailedEvent());
      }
    } finally {
      add(const InJobGetJobsLoadingEvent(isLoading: false));
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

  Future<void> completeJobApiCall(InJobCompleteJobClickEvent event, Emitter<InJobState> emit) async {
    try {
      add(const InJobCompleteJobLoadingEvent(isLoading: true));
      final response = await InJobService.completeJobService(jobId: event.jobId);

      if (response.isSuccess) {
        add(InJobCompleteJobSuccessEvent(successMessage: response.message));
      } else {
        add(InJobCompleteJobFailedEvent(failedMessage: response.message));
      }
    } finally {
      add(const InJobCompleteJobLoadingEvent(isLoading: false));
    }
  }
}
