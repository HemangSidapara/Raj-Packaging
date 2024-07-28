part of 'in_job_bloc.dart';

sealed class InJobState extends Equatable {
  const InJobState();
}

final class InJobInitial extends InJobState {
  @override
  List<Object> get props => [];
}

class InJobGetJobsLoadingState extends InJobState {
  final bool isLoading;

  const InJobGetJobsLoadingState({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class InJobGetJobsSuccessState extends InJobState {
  final List<get_jobs.Data> partyList;
  final String? successMessage;

  const InJobGetJobsSuccessState({required this.partyList, required this.successMessage});

  @override
  List<Object?> get props => [partyList, successMessage];
}

class InJobGetJobsFailedState extends InJobState {
  @override
  List<Object?> get props => [];
}

class InJobSearchOrderState extends InJobState {
  final List<get_jobs.Data> ordersList;

  const InJobSearchOrderState({required this.ordersList});

  @override
  List<Object?> get props => [ordersList];
}

class InJobCompleteJobLoadingState extends InJobState {
  final bool isLoading;

  const InJobCompleteJobLoadingState({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class InJobCompleteJobSuccessState extends InJobState {
  final String? successMessage;

  const InJobCompleteJobSuccessState({required this.successMessage});

  @override
  List<Object?> get props => [successMessage];
}

class InJobCompleteJobFailedState extends InJobState {
  final String? failedMessage;

  const InJobCompleteJobFailedState({required this.failedMessage});

  @override
  List<Object?> get props => [failedMessage];
}
