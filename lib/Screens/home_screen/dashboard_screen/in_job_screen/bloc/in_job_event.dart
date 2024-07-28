part of 'in_job_bloc.dart';

sealed class InJobEvent extends Equatable {
  const InJobEvent();
}

class InJobStartedEvent extends InJobEvent {
  @override
  List<Object?> get props => [];
}

class InJobGetJobsEvent extends InJobEvent {
  final bool isLoading;

  const InJobGetJobsEvent({this.isLoading = true});

  @override
  List<Object?> get props => [];
}

class InJobGetJobsLoadingEvent extends InJobEvent {
  final bool isLoading;

  const InJobGetJobsLoadingEvent({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class InJobGetJobsSuccessEvent extends InJobEvent {
  final List<get_jobs.Data> ordersList;
  final String? successMessage;

  const InJobGetJobsSuccessEvent({required this.ordersList, required this.successMessage});

  @override
  List<Object?> get props => [ordersList, successMessage];
}

class InJobGetJobsFailedEvent extends InJobEvent {
  @override
  List<Object?> get props => [];
}

class InJobSearchOrderEvent extends InJobEvent {
  final List<get_jobs.Data> ordersList;

  const InJobSearchOrderEvent({required this.ordersList});

  @override
  List<Object?> get props => [ordersList];
}

class InJobCompleteJobClickEvent extends InJobEvent {
  final String jobId;

  const InJobCompleteJobClickEvent({required this.jobId});

  @override
  List<Object?> get props => [jobId];
}

class InJobCompleteJobLoadingEvent extends InJobEvent {
  final bool isLoading;

  const InJobCompleteJobLoadingEvent({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class InJobCompleteJobSuccessEvent extends InJobEvent {
  final String? successMessage;

  const InJobCompleteJobSuccessEvent({required this.successMessage});

  @override
  List<Object?> get props => [successMessage];
}

class InJobCompleteJobFailedEvent extends InJobEvent {
  final String? failedMessage;

  const InJobCompleteJobFailedEvent({required this.failedMessage});

  @override
  List<Object?> get props => [failedMessage];
}
