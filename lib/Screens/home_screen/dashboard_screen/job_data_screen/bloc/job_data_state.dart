part of 'job_data_bloc.dart';

sealed class JobDataState extends Equatable {
  const JobDataState();
}

final class JobDataInitial extends JobDataState {
  @override
  List<Object> get props => [];
}

class JobDataGetJobsLoadingState extends JobDataState {
  final bool isLoading;

  const JobDataGetJobsLoadingState({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class JobDataGetJobsSuccessState extends JobDataState {
  final Map<String, dynamic> jobsList;
  final String? successMessage;

  const JobDataGetJobsSuccessState({required this.jobsList, required this.successMessage});

  @override
  List<Object?> get props => [jobsList, successMessage];
}

class JobDataGetJobsFailedState extends JobDataState {
  final Map<String, dynamic> jobsList;

  const JobDataGetJobsFailedState({required this.jobsList});

  @override
  List<Object?> get props => [jobsList];
}

class JobDataCompleteJobLoadingState extends JobDataState {
  final bool isLoading;

  const JobDataCompleteJobLoadingState({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class JobDataCompleteJobSuccessState extends JobDataState {
  final String? successMessage;

  const JobDataCompleteJobSuccessState({required this.successMessage});

  @override
  List<Object?> get props => [successMessage];
}

class JobDataCompleteJobFailedState extends JobDataState {
  final String? failedMessage;

  const JobDataCompleteJobFailedState({required this.failedMessage});

  @override
  List<Object?> get props => [failedMessage];
}
