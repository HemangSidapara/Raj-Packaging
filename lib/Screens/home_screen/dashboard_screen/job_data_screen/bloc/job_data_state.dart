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

  @override
  List<Object?> get props => [];
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

class JobDataUpdateAValueLoadingState extends JobDataState {
  final bool isLoading;

  const JobDataUpdateAValueLoadingState({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class JobDataUpdateAValueSuccessState extends JobDataState {
  final String? successMessage;

  const JobDataUpdateAValueSuccessState({required this.successMessage});

  @override
  List<Object?> get props => [successMessage];
}

class JobDataUpdateAValueFailedState extends JobDataState {
  final String? failedMessage;

  const JobDataUpdateAValueFailedState({required this.failedMessage});

  @override
  List<Object?> get props => [failedMessage];
}
