import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:raj_packaging/Network/models/jobs_models/get_job_data_model.dart' as get_job_data;
import 'package:raj_packaging/Network/services/job_data_services/job_data_service.dart';

part 'job_data_event.dart';
part 'job_data_state.dart';

class JobDataBloc extends Bloc<JobDataEvent, JobDataState> {
  List<get_job_data.Tabs> jobsList = <get_job_data.Tabs>[];

  JobDataBloc() : super(JobDataInitial()) {
    on<JobDataStartedEvent>((event, emit) {
      add(const JobDataGetJobsEvent());
    });

    on<JobDataGetJobsEvent>((event, emit) async {
      await getJobDataApiCall(event, emit);
    });

    on<JobDataGetJobsLoadingEvent>((event, emit) async {
      emit(JobDataGetJobsLoadingState(isLoading: event.isLoading));
    });

    on<JobDataGetJobsSuccessEvent>((event, emit) async {
      emit(JobDataGetJobsSuccessState(jobsList: event.jobsList, successMessage: event.successMessage));
    });

    on<JobDataGetJobsFailedEvent>((event, emit) async {
      emit(JobDataGetJobsFailedState());
    });

    on<JobDataCompleteJobClickEvent>((event, emit) async {
      await completeJobApiCall(event, emit);
    });

    on<JobDataCompleteJobLoadingEvent>((event, emit) async {
      emit(JobDataCompleteJobLoadingState(isLoading: event.isLoading));
    });

    on<JobDataCompleteJobSuccessEvent>((event, emit) async {
      emit(JobDataCompleteJobSuccessState(successMessage: event.successMessage));
    });

    on<JobDataCompleteJobFailedEvent>((event, emit) async {
      emit(JobDataCompleteJobFailedState(failedMessage: event.failedMessage));
    });
  }

  Future<void> getJobDataApiCall(JobDataGetJobsEvent event, Emitter<JobDataState> emit) async {
    try {
      add(JobDataGetJobsLoadingEvent(isLoading: event.isLoading));
      final response = await JobDataService.getJobDataService();

      if (response.isSuccess) {
        get_job_data.GetJobDataModel getJobDataModel = get_job_data.GetJobDataModel.fromJson(response.response?.data);
        jobsList.clear();
        jobsList.addAll(getJobDataModel.tabs ?? []);
        add(JobDataGetJobsSuccessEvent(jobsList: getJobDataModel.tabs ?? [], successMessage: response.message));
      } else {
        add(JobDataGetJobsFailedEvent());
      }
    } finally {
      add(const JobDataGetJobsLoadingEvent(isLoading: false));
    }
  }

  Future<void> completeJobApiCall(JobDataCompleteJobClickEvent event, Emitter<JobDataState> emit) async {
    try {
      add(const JobDataCompleteJobLoadingEvent(isLoading: true));
      final response = await JobDataService.completeJobService(jobId: event.jobId);

      if (response.isSuccess) {
        add(JobDataCompleteJobSuccessEvent(successMessage: response.message));
      } else {
        add(JobDataCompleteJobFailedEvent(failedMessage: response.message));
      }
    } finally {
      add(const JobDataCompleteJobLoadingEvent(isLoading: false));
    }
  }
}
