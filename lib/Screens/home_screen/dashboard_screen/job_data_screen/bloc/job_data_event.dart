part of 'job_data_bloc.dart';

sealed class JobDataEvent extends Equatable {
  const JobDataEvent();
}

class JobDataStartedEvent extends JobDataEvent {
  @override
  List<Object?> get props => [];
}

class JobDataGetJobsEvent extends JobDataEvent {
  final bool isLoading;

  const JobDataGetJobsEvent({this.isLoading = true});

  @override
  List<Object?> get props => [];
}

class JobDataGetJobsLoadingEvent extends JobDataEvent {
  final bool isLoading;

  const JobDataGetJobsLoadingEvent({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class JobDataGetJobsSuccessEvent extends JobDataEvent {
  final Map<String, dynamic> jobsList;
  final String? successMessage;

  const JobDataGetJobsSuccessEvent({required this.jobsList, required this.successMessage});

  @override
  List<Object?> get props => [jobsList, successMessage];
}

class JobDataGetJobsFailedEvent extends JobDataEvent {
  final Map<String, dynamic> jobsList;

  const JobDataGetJobsFailedEvent({required this.jobsList});

  @override
  List<Object?> get props => [jobsList];
}

class JobDataCompleteJobClickEvent extends JobDataEvent {
  final String jobId;

  const JobDataCompleteJobClickEvent({required this.jobId});

  @override
  List<Object?> get props => [jobId];
}

class JobDataCompleteJobLoadingEvent extends JobDataEvent {
  final bool isLoading;

  const JobDataCompleteJobLoadingEvent({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class JobDataCompleteJobSuccessEvent extends JobDataEvent {
  final String? successMessage;

  const JobDataCompleteJobSuccessEvent({required this.successMessage});

  @override
  List<Object?> get props => [successMessage];
}

class JobDataCompleteJobFailedEvent extends JobDataEvent {
  final String? failedMessage;

  const JobDataCompleteJobFailedEvent({required this.failedMessage});

  @override
  List<Object?> get props => [failedMessage];
}

class JobDataUpdateAValueClickEvent extends JobDataEvent {
  final String orderId;
  final String productId;
  final String aValue;
  final bool overFlap;

  const JobDataUpdateAValueClickEvent({
    required this.orderId,
    required this.productId,
    required this.aValue,
    required this.overFlap,
  });

  @override
  List<Object?> get props => [
        orderId,
        productId,
        aValue,
        overFlap,
      ];
}

class JobDataUpdateAValueLoadingEvent extends JobDataEvent {
  final bool isLoading;

  const JobDataUpdateAValueLoadingEvent({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class JobDataUpdateAValueSuccessEvent extends JobDataEvent {
  final String? successMessage;

  const JobDataUpdateAValueSuccessEvent({required this.successMessage});

  @override
  List<Object?> get props => [successMessage];
}

class JobDataUpdateAValueFailedEvent extends JobDataEvent {
  final String? failedMessage;

  const JobDataUpdateAValueFailedEvent({required this.failedMessage});

  @override
  List<Object?> get props => [failedMessage];
}
